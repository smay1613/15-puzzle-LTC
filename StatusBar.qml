import QtQuick 2.0

Item {
    id: root
    property int count: 0
    Rectangle {

        width: root.width / 2
        height: root.height
        anchors.right: root.right
        id: _moves

        border.color:  "black"
        border.width: 1

        radius: 10
        gradient: Gradient.SoftGrass

        Text {
            anchors.centerIn: _moves
            text: "Moves count: " + root.count
            font {
                bold: true
            }
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: _time

        property date startDate: new Date()
        property date currentDate: new Date()
        property date timeElapsed: new Date(currentDate - startDate)

        border.color:  "black"
        border.width: 1
        width: root.width / 2
        height: root.height
        anchors.left: root.left

        radius: 10
        gradient: Gradient.SoftGrass

        Text {
            anchors.centerIn: _time
            text: "Time elapsed: " + _time.timeElapsed.getMinutes() + ":" + _time.timeElapsed.getSeconds()
            function generateTimeText(minutes, seconds)
            {
                var message = "Time elapsed %1"
            }

            font {
                bold: true
            }
            verticalAlignment: Text.AlignVCenter
        }

        Timer {
                id: textTimer
                interval: 60
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: _time.currentDate = new Date()
        }
    }
}
