import QtQuick 2.5
import QtQuick.Window 2.11

Window {
    id: root

    width: 400
    height: 400
    visible: true
    title: qsTr("Boss puzzle")

    GameBoard
    {
        id: _board
        anchors.bottom: parent.bottom
        model: _controller.model
        size: _controller.boardSize

        width: parent.width
        height: parent.height*0.8

        hiddenElementValue: _controller.emptyValue
    }

    GameController
    {
        id: _controller
        Component.onCompleted: {
            _board.move.connect(_controller.makeMove);
        }
    }

    StatusBar {
        id: statusbar
        anchors.top: parent.top
        height: parent.height - _board.height
        width: parent.width
        count:_controller.moveCounter
    }
}
