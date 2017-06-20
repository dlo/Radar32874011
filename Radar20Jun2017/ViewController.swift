//
//  ViewController.swift
//  Radar13Jun2017
//
//  Created by Daniel Loewenherz on 6/13/17.
//  Copyright © 2017 Lionheart Software LLC. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    var store: HKHealthStore!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        store = HKHealthStore()
        title = "Radar13Jun2017"
        view.backgroundColor = .white

        let types: Set<HKSampleType> = [HKCategoryType.workoutType()]
        store.requestAuthorization(toShare: types, read: types) { (success, error) in
            let alert = UIAlertController(title: "Request Granted", message: "Please continue to import your workout data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default) { action in
                self.saveWorkout()
            })
            self.present(alert, animated: true)
        }
    }

    func saveWorkout() {
        let energy = HKQuantity(unit: .largeCalorie(), doubleValue: 100)
        let distance = HKQuantity(unit: .mile(), doubleValue: 100)

        let oneWeekInSeconds: TimeInterval = 60*60*24*7
        let workoutDuration: TimeInterval = 3600
        let startDate = Date().addingTimeInterval(-oneWeekInSeconds)
        let endDate = startDate.addingTimeInterval(3600)
        let workout = HKWorkout(activityType: .barre, start: startDate, end: endDate, duration: workoutDuration, totalEnergyBurned: energy, totalDistance: distance, device: nil, metadata: [:])

        store.save(workout) { (success, error) -> Void in
            guard success else {
                print("""
                    *** An error occurred while saving this
                    workout: \(error?.localizedDescription ?? "No error description was found.")
                    """)
                return
            }

            let alert = UIAlertController(title: "Workout has been saved.", message: "Please check Health.app to verify that the activity summary for today has been updated.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

