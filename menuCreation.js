function createMenuObject(component) {
    if (component.status === Component.Ready) {
            return finishCreation(component);
    } else {
            component.statusChanged.connect(finishCreation);
            return null;
    }
}

function finishCreation(component) {
    if (component.status === Component.Ready) {
        var createdComponent = component.createObject();
        if (createdComponent === null) {
            console.log("Error creating object");
        }
        return createdComponent;
    } else if (component.status === Component.Error) {
        console.log("Error loading component:", component.errorString());

        return null;
    }
}

function addMenuItem(parent, itemText)
{
    var menuComponent = Qt.createComponent("MenuItem.qml");
    if(menuComponent.status === Component.Ready) {
        var createdMenu = menuComponent.createObject(parent);
        createdMenu.text = "Text from your QList";
        console.log(createdMenu);
    }
}

