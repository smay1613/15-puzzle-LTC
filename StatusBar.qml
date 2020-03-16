import QtQuick 2.0

Rectangle {
    Text {
        id: timerTextField
        text: qsTr("00:00")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        width: parent.width / 2
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30

    }

    Text {
        id: moveCountTextField
        text: qsTr("0")
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        width: parent.width / 2
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 30

    }
    property int moveCount: 0
    property int seconds: 0

    function addMove() {
        ++moveCount;
        moveCountTextField.text = moveCount
    }

    Timer {
        id: timer
        repeat: true
        onTriggered: {
            ++seconds;
            timerTextField.text = new Date(seconds * 1000).toLocaleTimeString(Qt.locale(), "mm:" + "ss ")
        }
    }

    function reset() {
        moveCount = 0;
        seconds = 0;

        timerTextField.text = "00:00"
        moveCountTextField.text = moveCount

        timer.stop()
        timer.start()
    }

    border.color: "black"
    border.width: 3
}
