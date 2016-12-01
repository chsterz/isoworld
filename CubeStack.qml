import QtQuick 2.7
import QtQuick.Window 2.2

Item{
    property int stackheight: 3

    Repeater{
        id: cubeStack
        model: stackheight

        delegate: IsoCube{
            color: Qt.hsla(Math.random(),0.8,0.5,1)
            level: index
        }
    }
}
