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
        anchors.fill: parent
        model: _controller.model
        size: _controller.boardSize

        hiddenElementValue: _controller.emptyValue
    }

    GameController
    {
        id: _controller
        Component.onCompleted: {
            _board.move.connect(_controller.makeMove);
        }
    }
}

