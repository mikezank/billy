=begin
** Form generated from reading ui file 'main.ui'
**
** Created: Mon Jan 12 09:59:57 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :centralwidget
    attr_reader :scrollArea
    attr_reader :scrollAreaWidgetContents
    attr_reader :widget
    attr_reader :horizontalLayout
    attr_reader :maintainButton
    attr_reader :exitButton
    attr_reader :menubar
    attr_reader :statusbar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(856, 760)
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.objectName = "centralwidget"
    @scrollArea = Qt::ScrollArea.new(@centralwidget)
    @scrollArea.objectName = "scrollArea"
    @scrollArea.geometry = Qt::Rect.new(21, 21, 811, 631)
    @scrollArea.widgetResizable = true
    @scrollAreaWidgetContents = Qt::Widget.new()
    @scrollAreaWidgetContents.objectName = "scrollAreaWidgetContents"
    @scrollAreaWidgetContents.geometry = Qt::Rect.new(0, 0, 809, 629)
    @scrollArea.setWidget(@scrollAreaWidgetContents)
    @widget = Qt::Widget.new(@centralwidget)
    @widget.objectName = "widget"
    @widget.geometry = Qt::Rect.new(21, 658, 163, 32)
    @horizontalLayout = Qt::HBoxLayout.new(@widget)
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalLayout.setContentsMargins(0, 0, 0, 0)
    @maintainButton = Qt::PushButton.new(@widget)
    @maintainButton.objectName = "maintainButton"

    @horizontalLayout.addWidget(@maintainButton)

    @exitButton = Qt::PushButton.new(@widget)
    @exitButton.objectName = "exitButton"

    @horizontalLayout.addWidget(@exitButton)

    mainWindow.centralWidget = @centralwidget
    @menubar = Qt::MenuBar.new(mainWindow)
    @menubar.objectName = "menubar"
    @menubar.geometry = Qt::Rect.new(0, 0, 856, 22)
    mainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.objectName = "statusbar"
    mainWindow.statusBar = @statusbar

    retranslateUi(mainWindow)
    Qt::Object.connect(@maintainButton, SIGNAL('clicked()'), mainWindow, SLOT('do_maintenance()'))
    Qt::Object.connect(@exitButton, SIGNAL('clicked()'), mainWindow, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @maintainButton.text = Qt::Application.translate("MainWindow", "Maintain", nil, Qt::Application::UnicodeUTF8)
    @exitButton.text = Qt::Application.translate("MainWindow", "Exit", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

