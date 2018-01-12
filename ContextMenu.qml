import QtQuick.Controls 1.4

Menu {
    signal itemClicked()

    MenuItem {
        text: "Start new game"

        onTriggered: {
            itemClicked();
            destroy();
        }
    }
}
