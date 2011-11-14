#
#  AppDelegate.rb
#  MacRubySiri demo
#
#  Created by Matt Aimonetti on 11/14/11.
#  Copyleft 2011 . No rights reserved.
#
# Turn on System Preferences > Speech
# to be able to use the commands

class AppDelegate
  attr_accessor :menu, :recognizer, :panel, :panel_placeholder
  
  def applicationDidFinishLaunching(a_notification)
    puts "done launching"
    @menu = NSMenu.alloc.init
    setup_recognizer
    create_menu_items
    panel.orderFrontRegardless
  end
  
  def listen(sender)
    puts "listening"
  end
  
  def quit(sender)
    puts "ciao ciao"
    exit
  end
  
  def windowWillClose(sender)
    exit
  end
  
  def create_menu_items
    recognizer.commands.each do |command|
      @selected_cmd = command
      menuItem = menu.addItemWithTitle(command, action: 'show_from_menu:', keyEquivalent: "")
    end
    menu.addItem(NSMenuItem.separatorItem)
    menuItem = menu.addItemWithTitle("Quit", action: 'quit:', keyEquivalent: "q")
    menuItem.toolTip = "Click to Quit this App"
    menuItem.target = self
    
    statusItem = NSStatusBar.systemStatusBar.statusItemWithLength(NSSquareStatusItemLength)
    statusItem.menu = menu
    statusItem.highlightMode = true
    statusItem.toolTip = "Show Rubyists"
    statusItem.image = NSImage.imageNamed("menu-logo")
  end
  
  def setup_recognizer
    @recognizer = NSSpeechRecognizer.alloc.init
    recognizer.commands = ['Chad', 'Sansonetti','Hampton', 'Matz', 'Aaron', 'Leah', 'Rich']
    recognizer.delegate = self
    recognizer.ListensInForegroundOnly = false
    recognizer.startListening
  end
  
  # Method called when the speedch recognizer recognizes a command
  def speechRecognizer(sender, didRecognizeCommand:command)
    puts "vocal command: #{command}"
    show_portrait(command)
  end
  
  # Method called when the user clicks on a name in the menu
  def show_from_menu(sender)
    show_portrait(sender.title)
  end
  
  def show_portrait(name)
    image = NSImage.imageNamed(name)
    if image
      panel_placeholder.image = image
      width, height = image.size[0], image.size[1]
      frame = [panel.frame[0].x, panel.frame[0].y, width, height]
      panel.setFrame(frame, display:true, animate: false)
      panel_placeholder.image = image
      panel.orderFrontRegardless
    end
  end
  
end

