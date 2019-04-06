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
    
    @IBAction func speedSL(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        label.text = "Speed: \(currentValue)"
        debugPrint(currentValue)
        mqttClient.publish("rpi/speed", withString: "\(currentValue)")
    }
    @IBAction func steeringSL(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        angle.text = "Angle: \(currentValue)"
        debugPrint("Angle value: \(currentValue)")
        mqttClient.publish("rpi/servo", withString: "\(currentValue)")
    }
    
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

