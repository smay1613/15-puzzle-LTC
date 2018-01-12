import QtQuick 2.5
import QtQuick.Window 2.2
import ModelModule 1.0

Window {
    id: root

    property int boardSize: 5

    function playBoardShuffleModel()
    {
        return ModelFunctions.shuffleModel(_playBoardModel, boardSize * boardSize);
    }

    width: 800
    height: 800

    visible: true
    title: qsTr("Boss puzzle")

    GridView {
        id: _playBoardGrid
        anchors.centerIn: parent

        width: parent.width
        height: parent.height

        cellWidth: width / boardSize
        cellHeight: height / boardSize

        interactive: false

        model: _playBoardModel

        delegate: Item {
            id: _cell

            width: _playBoardGrid.cellWidth
            height: _playBoardGrid.cellHeight

            Tile {
                property int cellValue: value
                property int cellIndex: index

                width: _cell.width - 6
                height: _cell.height - 6

                anchors.centerIn: _cell

                visible: value != boardSize * boardSize - 1

                onCellClicked: {
                    ModelFunctions.modelMakeMove(_playBoardModel, index, boardSize);

                    if(ModelFunctions.isVictory(_playBoardModel, boardSize * boardSize)) {
                        ModelFunctions.openDialog(root, playBoardShuffleModel);
                    }
                }
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
            playBoardShuffleModel();
        }
    }

    ListModel {
        id: _playBoardModel
    }

    MouseArea {
        anchors.fill: parent

        propagateComposedEvents: true
        acceptedButtons: Qt.RightButton

        onClicked: {
            mouse.accepted = false;
            ModelFunctions.openMenu(root, playBoardShuffleModel);
        }
    }
}

