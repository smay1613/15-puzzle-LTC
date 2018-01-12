.pragma library

function shuffleModel(model) {
    var newModel = generateArrayRandomNumber();

    model.clear();

    for (var i = 0; i < 16; i++) {
        model.append({value: newModel[i]});
    }
}

function modelMakeMove(model, index, boardSize) {
    var right = (index + 1) % boardSize != 0 ? (index + 1) : "undefined";
    var left =  (index - 1) % boardSize != boardSize - 1 ? (index - 1) : "undefined";
    var down = (index + boardSize);
    var up =  (index - boardSize);

    for(var i = 0; i < 16; i++) {
        if (model.get(i).value === 15) {
            break;
        }
    }

    switch(i) {
        case right:
            model.move(index, right, 1);
            break;
        case left:
            model.move(index, left, 1);
            break;
        case up:
            model.move(index, up, 1);
            model.move(up + 1, index, 1);
            break;
        case down:
            model.move(index, down, 1);
            model.move(down - 1, index, 1);
            break;
    }
}

function isVictory(model) {
    for(var i = 0; i < 16; i++) {
        if(model.get(i).value !== i) {
            return false;
        }
    }
    return true;
}

function generateArrayRandomNumber() {
    var totalNumbers 		= 16;
    var arrayTotalNumbers 	= [];
    var arrayRandomNumbers 	= [];
    var tempRandomNumber;

    while (totalNumbers--) {
        arrayTotalNumbers.push(totalNumbers);
    }

    while (arrayTotalNumbers.length) {
        tempRandomNumber = Math.round(Math.random() * (arrayTotalNumbers.length - 1));
        arrayRandomNumbers.push(arrayTotalNumbers[tempRandomNumber]);
        arrayTotalNumbers.splice(tempRandomNumber, 1);
    }

    return arrayRandomNumbers;
}

function openMenu(parent, action) {
    var menuComponent = Qt.createComponent("ContextMenu.qml");
    var menu = menuComponent.createObject(parent);

    menu.popup();
    menu.itemClicked.connect(action);
}

function openDialog(parent, action) {
    var dialogComponent = Qt.createComponent("VictoryDialog.qml");
    var dialog = dialogComponent.createObject(parent);

    dialog.show();
    dialog.dialogAccepted.connect(action);
}
