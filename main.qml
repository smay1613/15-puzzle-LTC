import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Window
{
    id: root

    property int boardSize: 4

    function playBoardShuffle() {
        var board = generateArrayRandomNumber();

        _playBoardModel.clear();

        for (var i = 0; i < 16; i++) {
            _playBoardModel.append({value: board[i]});
        }
    }

    function playBoardMakeMove(index) {
        var right = (index + 1) % boardSize != 0 ? (index + 1) : "undefined";
        var left =  (index - 1) % boardSize != boardSize - 1 ? (index - 1) : "undefined";
        var down = (index + boardSize);
        var up =  (index - boardSize);

        for(var i = 0; i < 16; i++) {
            if (_playBoardModel.get(i).value === 15) {
                break;
            }
        }

        switch(i) {
            case right:
                _playBoardModel.move(index, right, 1);
                break;
            case left:
                _playBoardModel.move(index, left, 1);
                break;
            case up:
                _playBoardModel.move(index, up, 1);
                _playBoardModel.move(up + 1, index, 1);
                break;
            case down:
                _playBoardModel.move(index, down, 1);
                _playBoardModel.move(down - 1, index, 1);
                break;
        }
    }

    function isVictory() {
        for(var i = 0; i < 16; i++) {
            if(_playBoardModel.get(i).value !== i) {
                return false;
            }
        }
        return true;
    }

    function generateArrayRandomNumber() {
        var totalNumbers 		= 16;
        var arrayTotalNumbers 	= [];
        var arrayRandomNumbers 	= [];
        var tempRandomNumber;

        while (totalNumbers--) {
            arrayTotalNumbers.push(totalNumbers);
        }

        while (arrayTotalNumbers.length) {
            tempRandomNumber = Math.round(Math.random() * (arrayTotalNumbers.length - 1));
            arrayRandomNumbers.push(arrayTotalNumbers[tempRandomNumber]);
            arrayTotalNumbers.splice(tempRandomNumber, 1);
        }

        return arrayRandomNumbers;
    }

    width: 800
    height: 800

    visible: true
    title: qsTr("15th game")

    GridView {
        id: _playBoardGrid
        anchors.centerIn: parent

        width: parent.width
        height: parent.height

        cellWidth: width / boardSize
        cellHeight: height / boardSize

        interactive: false

        model: _playBoardModel

        delegate: Cell {
            id: _cellRectangle

            function cellInitialize() {
                cellValue = _playBoardModel.get(index).value;
                cellIndex = index;

                if(cellValue === 15) {
                    visible = false;
                }
            }

            width: _playBoardGrid.cellWidth + 3
            height: _playBoardGrid.cellHeight + 3

            onCellClicked: {
                if(button === Qt.LeftButton) {
                    playBoardMakeMove(index);
                    cellIndex = index;

                    if(isVictory()) {
                        var dialogComponent = Qt.createComponent("VictoryDialog.qml");
                        var dialog = dialogComponent.createObject(root);

                        dialog.show();
                        dialog.dialogAccepted.connect(playBoardShuffle);
                    }
                } else {
                    var menuComponent = Qt.createComponent("ContextMenu.qml");
                    var menu = menuComponent.createObject(root);

                    menu.popup();
                    menu.itemClicked.connect(playBoardShuffle);
                }

            }

            Component.onCompleted: {
                cellInitialize();
            }
        }

        move: Transition {
            NumberAnimation {
                properties: "x,y"
                duration: 400
                easing.type: Easing.InOutExpo
            }
        }

        Component.onCompleted: {
            playBoardShuffle();
        }
    }

    ListModel {
        id: _playBoardModel
    }
}

