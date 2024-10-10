//
//  ViewController.swift
//  Assignment2
//
//  Created by Nikunj Patel on 2024-10-10.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var labelQty: UILabel!
    
    @IBOutlet weak var btnBuy: UIButton!
    
    // Variables for selected quantity and product info
        var selectedQuantity: Int = 0
        var selectedProduct: Product?               // Stores the selected product
        var products: [Product] = []                // List of products for the UITableView
        
    // Sample Product struct
        struct Product {
            var name: String
            var price: Double
            var stock: Int
        }
    
    // Function to handle digit button presses
        @IBAction func digitButtonPressed(_ sender: UIButton) {
            // Get the digit from the button title
            if let digitText = sender.titleLabel?.text, let digit = Int(digitText) {
                // Append the digit to the current selected quantity
                if selectedQuantity == 0 {
                    selectedQuantity = digit
                } else {
                    // Append new digit
                    selectedQuantity = selectedQuantity * 10 + digit
                }
                
                // Update the Quantity Label with the new quantity
                labelQty.text = "\(selectedQuantity)"
            }
        }
    
    // MARK: - Buy Button Action
        @IBAction func btnBuyPressed(_ sender: UIButton) {
            guard let product = selectedProduct else {
                showAlert(title: "No Product Selected", message: "Please select a product to purchase.")
                return
            }
            
            if selectedQuantity > product.stock {
                // Show alert if quantity is greater than stock
                showAlert(title: "Insufficient Stock", message: "Only \(product.stock) units are available.")
            } else {
                // Calculate total price and update the label
                let totalPrice = Double(selectedQuantity) * product.price
                labelTotal.text = String(format: "$%.2f", totalPrice)
                
                // Update product stock and reset labels
                if let index = products.firstIndex(where: { $0.name == product.name }) {
                    products[index].stock -= selectedQuantity
                }
                
                // Reset quantity and quantity label
                resetQuantityAndTotal()
                
                // Confirmation Alert
                showAlert(title: "Purchase Successful", message: "You bought \(selectedQuantity) units of \(product.name) for $\(totalPrice).")
            }
        }
    
    // MARK: - Helper Functions
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        func resetQuantityAndTotal() {
            selectedQuantity = 0
            labelQty.text = "\(selectedQuantity)"
            labelTotal.text = "$0.00"
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                products = [
                    Product(name: "Hat", price: 10.0, stock: 20),
                    Product(name: "Shirt", price: 15.0, stock: 30),
                    Product(name: "Shoes", price: 50.0, stock: 10)
                ]
                
                // Set initial labels
                labelType.text = "Select a Product"
                labelQty.text = "0"
                labelTotal.text = "$0.00"
    }


}

