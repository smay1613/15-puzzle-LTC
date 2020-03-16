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
//        anchors.fill: parent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 5
        model: _controller.model
        size: _controller.boardSize

        hiddenElementValue: _controller.emptyValue
    }

    GameController
    {
        id: _controller
        Component.onCompleted: {
            _board.move.connect(root.move);
            _statusBar.reset()
            _controller.winner.connect(root.showWinScreen)
            _victory.newGame.connect(newGame)
        }


    }

    function showWinScreen() {
        _victory.open()
    }

    function move(index) {
        if (_controller.makeMove(index))
            _statusBar.addMove()
    }

    function newGame() {
        _statusBar.reset()
        _controller.newGame()
        _victory.close()
    }

    StatusBar {
        id:_statusBar
        anchors.top: _board.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    Victory {
        id:_victory
        visible: false
    }
}

