//
//  ViewController.swift
//  EGEN 310
//
//  Created by KyleWebster on 3/5/19.
//  Copyright © 2019 Kyle Webster. All rights reserved.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController {
    
    //Instantiate CocoaMQTT as mqttClient
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "169.254.213.44", port: 1883)
    private var current = 3
    
    //switch to enable and disable forward enable or disable
    @IBAction func forwardSW(_ sender: UISwitch) {
        if sender.isOn {
            mqttClient.publish("rpi/gpio", withString: "for on")
        }
        else {
            mqttClient.publish("rpi/gpio", withString: "for off")
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var angle: UILabel!
    //Slider to control speed, is not continuous update due to Raspberry Pi CPU and RAM memory
    @IBAction func speedSL(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        label.text = "Speed: \(currentValue)"
        debugPrint(currentValue)
        mqttClient.publish("rpi/speed", withString: "\(currentValue)")
    }
    
    //Slider to control the steering, continuous update with value ranges of 1-5 where 1 is left and 5 is right
    @IBAction func steeringSL(_ sender: UISlider) {
        let val = Int(sender.value)
        angle.text = "Angle \(val)"
        if val != current{
            if val == 1{
                debugPrint("1")
                mqttClient.publish("rpi/servo", withString: "1")
            }else if val == 2{
                debugPrint("2")
                mqttClient.publish("rpi/servo", withString: "2")
            }else if val == 3{
                debugPrint("3")
                mqttClient.publish("rpi/servo", withString: "3")
            }else if val == 4{
                debugPrint("4")
                mqttClient.publish("rpi/servo", withString: "4")
            }else{
                debugPrint("5")
                mqttClient.publish("rpi/servo", withString: "5")
        }
        current = val
    }
    }
    //switch to enable backwards drive either on or off
    @IBAction func backwardSW(_ sender: UISwitch) {
        if sender.isOn{
            mqttClient.publish("rpi/gpio", withString: "back on")
        }
        else{
            mqttClient.publish("rpi/gpio", withString: "back off")
        }
    }
    
    //Executes when conenct button is pressed
    @IBAction func connectButton(_ sender: UIButton) {
        mqttClient.connect()
    }
    
    //Executes when disconnect button is pressed
    @IBAction func disconnectButton(_ sender: Any) {
        mqttClient.disconnect()
    }
    
    //Executes after loading the view for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
