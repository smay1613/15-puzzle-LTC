import QtQuick 2.10
import QtQml.Models 2.11

Item {
    id: root

    property int boardSize: 4
    readonly property int totalCount: boardSize * boardSize
    readonly property int emptyValue: totalCount

    readonly property alias model: _model
    property int correctValueCount: 0
    signal winner()
    function makeMove(index)
    {
        console.assert(index >= 0 && index < totalCount, "Invalid index passed!");
        console.debug("Performing move for", index, "with value", _model.get(index).value);

        var empty = _internal.emptyIndex();
        if (!_internal.isAdjacent(index, empty))
        {
            console.debug("Nothing to do. Hidden value index:", empty);
            return false;
        }

        var down = index + boardSize;
        var up = index - boardSize;

        model.move(index, empty, 1);

        switch(empty) {
            case up:
                model.move(up + 1, index, 1);
                break;
            case down:
                model.move(down - 1, index, 1);
                break;
        }

             checkWinner()
        return true;
    }

    function checkWinner() {
        for (var i = 0; i < model.count; ++i) {
            if (model.get(i).value - 1 !== i)
                return
        }
        winner()
    }

    function newGame() {
        _internal.shuffleBoard();
        correctValueCount = 0;
    }

    QtObject {
        id: _internal

        function generateBoard()
        {
            var boardValues = [];

            for (var i = 1; i <= totalCount; i++) {
               boardValues.push(i);
            }

            return boardValues;
        }

        function shuffleBoard()
        {
            var board = generateBoard();
            var size = totalCount;

            for (var index = size - 1;
                 index > 0;
                 index--)
            {
                let randomIndex = Math.floor(Math.random() * (index + 1));
                var buffer = board[index];
                board[index] = board[randomIndex];
                board[randomIndex] = buffer;
            }

            model.clear();
            for (var i = 0; i < size; i++)
            {
                model.append({value: board[i]})
            }
        }

        function isAdjacent(index1, index2)
        {
            var distance = Math.abs(index1 - index2);
            var onSameRow =  row(index1) === row(index2);

            return distance === boardSize
                   || (distance === 1 && onSameRow);
        }

        function row(index)
        {
            return Math.floor(index / root.boardSize);
        }

        function column(index)
        {
            return index % root.boardSize;
        }

        function emptyIndex()
        {
            for (var i = 0; i < model.count; i++)
            {
                if (model.get(i).value === emptyValue)
                {
                    return i;
                }
            }
        }
    }

    ListModel
    {
        id: _model
    }

    Component.onCompleted: {
        _internal.shuffleBoard();
    }
}
