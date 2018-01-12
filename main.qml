import QtQuick 2.5
import QtQuick.Window 2.2
import ModelModule 1.0

Window
{
    id: root

    property int boardSize: 4

    function playBoardShuffleModel()
    {
        return ModelFunctions.shuffleModel(_playBoardModel);
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

            property int cellValue: value
            property int cellIndex: index

            width: _playBoardGrid.cellWidth + 3
            height: _playBoardGrid.cellHeight + 3

            visible: value != 15

            onCellClicked: {
                    ModelFunctions.modelMakeMove(_playBoardModel, index, boardSize);

                    if(ModelFunctions.isVictory(_playBoardModel)) {
                        ModelFunctions.openDialog(root, playBoardShuffleModel);
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
            ModelFunctions.shuffleModel(_playBoardModel);
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

