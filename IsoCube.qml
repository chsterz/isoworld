import QtQuick 2.7
import QtQuick.Window 2.2

Item {
    id: isoCube
    
    property int xpos
    property int ypos

    property color color
    property int level: 0
    z: (level+1) * 1000 - ypos - xpos

    transform: Translate{x:xpos*32 + level*32; y: ypos*32 + level*32}

    // Top Face
    Rectangle{
        width: 32
        height: 32 - 1
        antialiasing: true
        
        color: Qt.lighter(isoCube.color)
        
        transform: Matrix4x4 {
            property matrix4x4 skewMatrix: Qt.matrix4x4(1,0,0,32,
                                                        0,1,0,32,
                                                        0,0,1,0,
                                                        0,0,0,1)
            matrix: skewMatrix
        }

        FaceMouseArea {
            creationOffset: Qt.vector3d(0, 0, 1)
        }
    }

    // left Face
    Rectangle{
        width: 32
        height: 32

        color: isoCube.color
        antialiasing: true

        transform: Matrix4x4 {
            property matrix4x4 skewMatrix: Qt.matrix4x4(1,0,0,0,
                                                        1,1,0,0,
                                                        0,0,1,0,
                                                        0,0,0,1)
            matrix: skewMatrix
        }

        FaceMouseArea {
            creationOffset: Qt.vector3d(-1, 0, 0)
        }
    }

    //Right Face
    Rectangle{
        width: 32 - 1
        height: 32
        
        color: Qt.darker(isoCube.color)
        antialiasing: true
        
        transform: Matrix4x4 {
            property matrix4x4 skewMatrix: Qt.matrix4x4(1,1,0,0,
                                                        0,1,0,0,
                                                        0,0,1,0,
                                                        0,0,0,1)
            matrix: skewMatrix
        }

        FaceMouseArea {
            creationOffset: Qt.vector3d(0, -1, 0)
        }
    }
}
