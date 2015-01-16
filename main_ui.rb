=begin
** Form generated from reading ui file 'main.ui'
**
** Created: Thu Jan 15 07:21:51 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :actionActive_MasterBills
    attr_reader :actionInactive_MasterBills
    attr_reader :actionPaid_Bills
    attr_reader :actionPreferences
    attr_reader :actionKeys
    attr_reader :centralwidget
    attr_reader :scrollArea
    attr_reader :scrollAreaWidgetContents
    attr_reader :widget
    attr_reader :horizontalLayout
    attr_reader :maintainButton
    attr_reader :exitButton
    attr_reader :menubar
    attr_reader :menuFile
    attr_reader :menuExport
    attr_reader :menuMaintain
    attr_reader :statusbar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(856, 760)
    @actionActive_MasterBills = Qt::Action.new(mainWindow)
    @actionActive_MasterBills.objectName = "actionActive_MasterBills"
    @actionInactive_MasterBills = Qt::Action.new(mainWindow)
    @actionInactive_MasterBills.objectName = "actionInactive_MasterBills"
    @actionPaid_Bills = Qt::Action.new(mainWindow)
    @actionPaid_Bills.objectName = "actionPaid_Bills"
    @actionPreferences = Qt::Action.new(mainWindow)
    @actionPreferences.objectName = "actionPreferences"
    @actionKeys = Qt::Action.new(mainWindow)
    @actionKeys.objectName = "actionKeys"
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
    @menubar.geometry = Qt::Rect.new(0, 0, 856, 27)
    @font = Qt::Font.new
    @font.pointSize = 18
    @menubar.font = @font
    @menuFile = Qt::Menu.new(@menubar)
    @menuFile.objectName = "menuFile"
    @menuExport = Qt::Menu.new(@menuFile)
    @menuExport.objectName = "menuExport"
    @font1 = Qt::Font.new
    @font1.pointSize = 16
    @menuExport.font = @font1
    @menuMaintain = Qt::Menu.new(@menubar)
    @menuMaintain.objectName = "menuMaintain"
    mainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.objectName = "statusbar"
    mainWindow.statusBar = @statusbar

    @menubar.addAction(@menuFile.menuAction())
    @menubar.addAction(@menuMaintain.menuAction())
    @menuFile.addAction(@menuExport.menuAction())
    @menuFile.addAction(@actionPreferences)
    @menuExport.addAction(@actionActive_MasterBills)
    @menuExport.addAction(@actionInactive_MasterBills)
    @menuExport.addAction(@actionPaid_Bills)
    @menuMaintain.addAction(@actionKeys)

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
    @actionActive_MasterBills.text = Qt::Application.translate("MainWindow", "Active MasterBills", nil, Qt::Application::UnicodeUTF8)
    @actionInactive_MasterBills.text = Qt::Application.translate("MainWindow", "Inactive MasterBills", nil, Qt::Application::UnicodeUTF8)
    @actionPaid_Bills.text = Qt::Application.translate("MainWindow", "Paid Bills", nil, Qt::Application::UnicodeUTF8)
    @actionPreferences.text = Qt::Application.translate("MainWindow", "Preferences", nil, Qt::Application::UnicodeUTF8)
    @actionKeys.text = Qt::Application.translate("MainWindow", "Keys", nil, Qt::Application::UnicodeUTF8)
    @maintainButton.text = Qt::Application.translate("MainWindow", "Maintain", nil, Qt::Application::UnicodeUTF8)
    @exitButton.text = Qt::Application.translate("MainWindow", "Exit", nil, Qt::Application::UnicodeUTF8)
    @menuFile.title = Qt::Application.translate("MainWindow", "File", nil, Qt::Application::UnicodeUTF8)
    @menuExport.title = Qt::Application.translate("MainWindow", "Export", nil, Qt::Application::UnicodeUTF8)
    @menuMaintain.title = Qt::Application.translate("MainWindow", "Maintain", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

