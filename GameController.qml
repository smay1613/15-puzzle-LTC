import QtQuick 2.10
import QtQml.Models 2.11
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property int boardSize: 3
    property int moveCounter: 0
    readonly property int totalCount: boardSize * boardSize
    readonly property int emptyValue: totalCount

    readonly property alias model: _model

    function makeMove(index)
    {
        console.assert(index >= 0 && index < totalCount, "Invalid index passed!");
        console.debug("Performing move for", index, "with value", _model.get(index).value);

        var empty = _internal.emptyIndex();
        if (!_internal.isAdjacent(index, empty))
        {
            console.debug("Nothing to do. Hidden value index:", empty);
            return;
        }

        var down = index + boardSize;
        var up = index - boardSize;

        model.move(index, empty, 1);

        switch(empty) {
            case up:
                model.move(up + 1, index, 1);
                break;
            case down:
                model.move(down - 1, index, 1);
                break;
        }
        moveCounter++;
        if (_internal.isGameFinished())
            popup.open();
    }

    QtObject {
        id: _internal

        function generateBoard()
        {
            var boardValues = [];

            for (var i = 1; i <= totalCount; i++) {
               boardValues.push(i);
            }

            return boardValues;
        }

        function shuffleBoard()
        {
            var board = generateBoard();
            var size = totalCount;

            for (var index = size - 1;
                 index > 0;
                 index--)
            {
                let randomIndex = Math.floor(Math.random() * (index + 1));
                var buffer = board[index];
                board[index] = board[randomIndex];
                board[randomIndex] = buffer;
            }

            model.clear();
            for (var i = 0; i < size; i++)
            {
                model.append({value: board[i]})
            }
        }

        function isAdjacent(index1, index2)
        {
            var distance = Math.abs(index1 - index2);
            var onSameRow =  row(index1) === row(index2);

            return distance === boardSize
                   || (distance === 1 && onSameRow);
        }

        function row(index)
        {
            return Math.floor(index / root.boardSize);
        }

        function column(index)
        {
            return index % root.boardSize;
        }

        function emptyIndex()
        {
            for (var i = 0; i < model.count; i++)
            {
                if (model.get(i).value === emptyValue)
                {
                    return i;
                }
            }
        }

        function isGameFinished() {
            for (var i = 0; i < model.count - 1; i++)
            {
                if (model.get(i).value !== i+1)
                    return false;
            }
            return true;
        }
    }

    ListModel
    {
        id: _model
    }

    Component.onCompleted: {
        _internal.shuffleBoard();
    }

    Popup {
        id: popup
        width: 300
        height: 200
        modal: true
        focus: true
        anchors.centerIn: root.anchors.centerIn
        Text {
            id: congratulations
            text: qsTr("CONGRATULATIONS!")
            verticalAlignment: Text.AlignVCenter
        }

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        background: Rectangle {
            id: _restart
            border.color: "black"
            border.width: 1
            radius: 2
            gradient: Gradient.SoftGrass

            layer.enabled: _quit.enabled
            layer.effect: DropShadow {
                anchors.fill: parent
                verticalOffset: 2
                horizontalOffset: verticalOffset / 2
            }
        }

        contentData:
            Button {
                height: parent.height/ 5
                width: parent.width / 2.5
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                text: "Restart"
                onClicked: {
                    popup.close();
                    _internal.shuffleBoard();
                    moveCounter = 0;
                }

                background: Rectangle {
                    border.color: "black"
                    border.width: 1
                    radius: 2
                    color: "lightyellow"

                    layer.enabled: _quit.enabled
                    layer.effect: DropShadow {
                        anchors.fill: parent
                        verticalOffset: 2
                        horizontalOffset: verticalOffset / 2
                    }
                }
            }

            Button {
                id: _quit
                height: parent.height/ 5
                width: parent.width / 2.5
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                text: "Quit"
                onClicked: Qt.quit()

                background: Rectangle {
                    border.color: "black"
                    border.width: 1
                    radius: 2
                    color: "lightyellow"

                    layer.enabled: _quit.enabled
                    layer.effect: DropShadow {
                        anchors.fill: parent
                        verticalOffset: 2
                        horizontalOffset: verticalOffset / 2
                    }
                }

            }


    }

}
