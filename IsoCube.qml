import QtQuick 2.7
import QtQuick.Window 2.2

Item {
    id: isoCube
    
    property int xpos: 0
    property int ypos: 0
    property bool isRootCube: false

    property color color: "green"
    property int level: 0
    z: (level+1) * 1000 - y -x

    transform: Translate{x:xpos*30 + level*32; y: ypos*30 + level*32}

    Component.onCompleted: {color = Qt.hsla(Math.random(),0.8,0.5,1)}

    Rectangle{
        width: 30
        height: 30
        antialiasing: true
        
        color: Qt.lighter(isoCube.color)
        
        transform: Matrix4x4{
            property matrix4x4 skewMatrix: Qt.matrix4x4(1,0,0,32,
                                                        0,1,0,32,
                                                        0,0,1,0,
                                                        0,0,0,1)
            matrix: skewMatrix
        }

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            onWheel: {parent.parent.color = Qt.hsla(Math.random(),0.8,0.5,1)}
            onClicked: {
                if(mouse.button & Qt.LeftButton) {
                    isoCube.parent.createCubeAt(isoCube.xpos, isoCube.ypos, isoCube.level+1);
                }else if(!isRootCube){
                    isoCube.destroy()
                }
            }
        }

    }
    
    Rectangle{
        width: 30
        height: 32
        
        color: Qt.darker(isoCube.color)
        antialiasing: true
        
        transform: Matrix4x4{
            property matrix4x4 skewMatrix: Qt.matrix4x4(1,1,0,0,
                                                        0,1,0,0,
                                                        0,0,1,0,
                                                        0,0,0,1)
            matrix: skewMatrix
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            onWheel: {parent.parent.color = Qt.hsla(Math.random(),0.8,0.5,1)}
            onClicked: {
                if(mouse.button & Qt.LeftButton) {
                    isoCube.parent.createCubeAt(isoCube.xpos, isoCube.ypos-1, isoCube.level);
                }else if(!isRootCube){
                    isoCube.destroy()
                }
            }
        }
    }
    Rectangle{
        width: 32
        height: 30
        
        color: isoCube.color
        antialiasing: true

        transform: Matrix4x4{
            property matrix4x4 skewMatrix: Qt.matrix4x4(1,0,0,0,
                                                        1,1,0,0,
                                                        0,0,1,0,
                                                        0,0,0,1)
            matrix: skewMatrix
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            onWheel: {parent.parent.color = Qt.hsla(Math.random(),0.8,0.5,1)}
            onClicked: {
                if(mouse.button & Qt.LeftButton) {
                    isoCube.parent.createCubeAt(isoCube.xpos-1, isoCube.ypos, isoCube.level);
                }else if(!isRootCube){
                    isoCube.destroy()
                }
            }
        }
    }
}
