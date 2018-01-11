import QtQuick 2.5
import QtQuick.Window 2.2

import "functions.js" as ModelFunctions

Window
{
    id: root

    property int boardSize: 4

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

            function playBoardShuffleModel() //impossible to connect without wrapping
            {
                return ModelFunctions.shuffleModel(_playBoardModel);
            }

            width: _playBoardGrid.cellWidth + 3
            height: _playBoardGrid.cellHeight + 3

            visible: value != 15

            onCellClicked: {
                if(button === Qt.LeftButton) {
                    ModelFunctions.modelMakeMove(index, _playBoardModel);

                    if(ModelFunctions.isVictory(_playBoardModel)) {
                        var dialogComponent = Qt.createComponent("VictoryDialog.qml");
                        var dialog = dialogComponent.createObject(root);

                        dialog.show();
                        dialog.dialogAccepted.connect(playBoardShuffleModel);
                    }
                } else {
                    var menuComponent = Qt.createComponent("ContextMenu.qml");
                    var menu = menuComponent.createObject(root);

                    menu.popup();
                    menu.itemClicked.connect(playBoardShuffleModel);
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
}

