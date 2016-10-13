/* =================================================
 * This file is part of the TTK Music Player project
 * Copyright (c) 2014 - 2016 Greedysky Studio
 * All rights reserved!
 * Redistribution and use of the source code or any derivative
 * works are strictly forbiden.
   =================================================*/

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import "Core"

Item {
    id: ttkMainPage
    width: parent.width
    height: parent.height

    Connections {
        target: TTK_APP
        onImportSongFinished: {
            funcLocalMusic.subTitle = TTK_APP.mediaCount(ttkTheme.music_normal_list);
        }
        onCurrentIndexChanged: {
            funcLocalMusic.subTitle = TTK_APP.mediaCount(ttkTheme.music_normal_list);
            funcRecent.subTitle = TTK_APP.mediaCount(ttkTheme.music_recent_list);
        }
    }

    ColumnLayout {
        spacing: 0
        anchors.fill: parent

        ///top bar
        Rectangle {
            id: ttkMainMenubar
            Layout.fillWidth: true
            height: dpHeight(ttkTheme.topbar_height)
            color: ttkTheme.topbar_background

            RowLayout {
                id: mainMenubarLayout
                spacing: 2
                anchors.fill: parent

                TTKImageButton {
                    source: "qrc:/image/top_tab_more_selected"
                    Layout.preferredWidth: dpWidth(50)
                    Layout.preferredHeight: dpHeight(50)
                    anchors.left: parent.left
                    onPressed: {
                        ttkMainStackView.push("qrc:/qmls/TTKMainSettingPage.qml");
                    }
                }

                TTKImageButton {
                    source: "qrc:/image/top_tab_search_selected"
                    Layout.preferredWidth: dpWidth(50)
                    Layout.preferredHeight: dpHeight(50)
                    anchors.right: parent.right
                    onPressed: {
                        ttkMainStackView.push("qrc:/qmls/TTKOnlineSearchPage.qml");
                    }
                }
            }
        }

        ///main body
        ScrollView {
            Layout.preferredWidth: ttkMainWindow.width
            Layout.preferredHeight: ttkMainStackView.height
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff

            Rectangle {
                anchors {
                    right: parent.right
                    top: parent.top
                }
                width: ttkMainWindow.width
                height: dpHeight(800)
                color: "#EEEEEE"

                ColumnLayout {
                    spacing: 5
                    anchors.fill: parent

                    ///userWidget
                    Rectangle {
                        id: userWidget
                        Layout.preferredWidth: ttkMainWindow.width
                        Layout.preferredHeight: dpHeight(80)
                        anchors.left: parent.left
                        color: ttkTheme.white

                        TTKRadiusImage {
                            id: userImage
                            width: parent.height
                            height: parent.height
                            anchors {
                                left: parent.left
                                top: parent.top
                                leftMargin: dpHeight(10)
                            }
                            color: ttkTheme.alphaLv0
                            foreground: "qrc:/image/test"
                            background: "qrc:/image/radius_mask"
                        }

                        Text {
                            id: userMainTitle
                            anchors {
                                left: userImage.right
                                top: parent.top
                                leftMargin: dpHeight(10)
                                topMargin: dpHeight(10)
                            }
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: parent.height/4
                            text: qsTr("个性电台")
                        }

                        Text {
                            id: userSubTitle
                            anchors {
                                left: userImage.right
                                top: userMainTitle.bottom
                                leftMargin: dpHeight(10)
                                topMargin: dpHeight(10)
                            }
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: ttkTheme.gray
                            text: qsTr("偶遇身边好音乐")
                        }
                    }

                    ///functionWidget
                    Rectangle {
                        id: functionWidget
                        Layout.preferredWidth: ttkMainWindow.width
                        Layout.preferredHeight: dpHeight(310)
                        anchors.left: parent.left
                        color: ttkTheme.white

                        TTKMainFunctionItem {
                            id: funcLocalMusic
                            anchors {
                                left: parent.left
                                top: parent.top
                            }
                            source: "qrc:/image/mymusic_icon_allsongs_highlight"
                            mainTitle: qsTr("本地歌曲")
                            subTitle: TTK_APP.mediaCount(ttkTheme.music_normal_list)
                            onPressed: {
                                TTK_APP.setToolBoxIndex(ttkTheme.music_normal_list);
                                ttkMainStackView.push("qrc:/qmls/TTKMusicListsPage.qml");
                            }
                        }

                        TTKMainFunctionItem {
                            id: funcDownload
                            anchors {
                                left: funcLocalMusic.right
                                top: parent.top
                            }
                            source: "qrc:/image/mymusic_icon_download_normal"
                            mainTitle: qsTr("下载歌曲")
                        }

                        TTKMainFunctionItem {
                            id: funcRecent
                            anchors {
                                left: funcDownload.right
                                top: parent.top
                            }
                            source: "qrc:/image/mymusic_icon_history_highlight"
                            mainTitle: qsTr("最近播放")
                            subTitle: TTK_APP.mediaCount(ttkTheme.music_recent_list)
                            onPressed: {
                                TTK_APP.setToolBoxIndex(ttkTheme.music_recent_list);
                                ttkMainStackView.push("qrc:/qmls/TTKMusicRecentListsPage.qml");
                            }
                        }

                        TTKMainFunctionItem {
                            id: funcMyLove
                            anchors {
                                left: parent.left
                                top: funcLocalMusic.bottom
                            }
                            source: "qrc:/image/mymusic_icon_favorite_normal"
                            mainTitle: qsTr("我喜欢")
                        }

                        TTKMainFunctionItem {
                            id: funcMusicVideo
                            anchors {
                                left: funcMyLove.right
                                top: funcLocalMusic.bottom
                            }
                            source: "qrc:/image/mymusic_icon_mv_highlight"
                            mainTitle: qsTr("下载MV")
                        }

                        TTKMainFunctionItem {
                            id: funcIdentifySong
                            anchors {
                                left: funcMusicVideo.right
                                top: funcLocalMusic.bottom
                            }
                            source: "qrc:/image/mymusic_icon_recognizer_normal"
                            mainTitle: qsTr("听歌识曲")
                            subTitle: qsTr("[绿旋风]")
                        }
                    }

                    ///radioWidget
                    Rectangle {
                        id: radioWidget
                        Layout.preferredWidth: ttkMainWindow.width
                        Layout.preferredHeight: dpHeight(70)
                        anchors.left: parent.left
                        color: ttkTheme.white

                        Rectangle {
                            id: radioImage
                            width: parent.height
                            height: parent.height
                            anchors {
                                left: parent.left
                                top: parent.top
                                leftMargin: dpHeight(10)
                            }
                            color: ttkTheme.alphaLv0

                            Image {
                                anchors.fill: parent
                                source: "qrc:/image/test"
                            }
                        }

                        Text {
                            id: radioMainTitle
                            anchors {
                                left: radioImage.right
                                top: parent.top
                                leftMargin: dpHeight(10)
                                topMargin: dpHeight(10)
                            }
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: parent.height/4
                            text: qsTr("个性电台")
                        }

                        Text {
                            id: radioSubTitle
                            anchors {
                                left: radioImage.right
                                top: radioMainTitle.bottom
                                leftMargin: dpHeight(10)
                                topMargin: dpHeight(10)
                            }
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: ttkTheme.gray
                            text: qsTr("偶遇身边好音乐")
                        }
                    }

                    ///songsWidget
                    Rectangle {
                        id: songsWidget
                        Layout.preferredWidth: ttkMainWindow.width
                        Layout.preferredHeight: dpHeight(300)

                        ColumnLayout {
                            spacing: 0
                            anchors.fill: parent

                            Rectangle {
                                Layout.fillWidth: true
                                height: dpHeight(50)
                                Layout.alignment: Qt.AlignCenter

                                Text {
                                    text: qsTr("我 的 歌 单")
                                    horizontalAlignment: Qt.AlignHCenter
                                    verticalAlignment: Qt.AlignVCenter
                                    width: songsWidget.width
                                    height: parent.height
                                }

                                Image {
                                    id: image
                                    anchors.right: parent.right
                                    width: parent.height
                                    height: parent.height
                                    source: "qrc:/image/ic_toolbar_advance"
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                color: ttkTheme.alphaLv10
                                height: 1
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: dpHeight(150)

                                Rectangle {
                                    id: songsItemWidget
                                    height: dpHeight(70)
                                    width: dpWidth(70)
                                    color: ttkTheme.alphaLv11
                                    anchors {
                                        left: parent.left
                                        top: parent.top
                                        leftMargin: dpHeight(10)
                                        topMargin: dpHeight(10)
                                    }

                                    Image {
                                        id: songsItemImage
                                        anchors.fill: parent
                                        source: "qrc:/image/ic_add_folder"
                                    }

                                    Text {
                                        text: qsTr("新建歌单")
                                        anchors {
                                            left: songsItemImage.right
                                            top: parent.top
                                            leftMargin: dpHeight(10)
                                        }
                                        horizontalAlignment: Qt.AlignHCenter
                                        verticalAlignment: Qt.AlignVCenter
                                        width: parent.width
                                        height: parent.height
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
