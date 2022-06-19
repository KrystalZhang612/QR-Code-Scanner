//
//  ContentView.swift
//  QRCodeScanner
//
//  Created by Krystal Zhang on 6/18/22.
//  The 4th commit

import SwiftUI
import CodeScanner

struct ContentView: View {
    //initialize the scanner as off
    @State var isPresentingScanner = false
    //beginning UI page message to prompt QR code from user
    @State var scannedCode: String = "Scan a QR code to get started"
    //next we need to create a scanner sheet
    //since we want different views to pop up inside
    //that can actually take picture without having to create an element in body
    var scannerSheet: some View{
        //specify the code type as QR code
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result{
                    //In order to prevent the occurence of “Cannot assign value of type
                    //‘ScanResult’ to type ‘String’ “ error at self.scannedCode= code,
                    //we need to use self.scannedCode = code.string instead to make the
                    //value types compatible.
                    self.scannedCode = code.string
                    //scanning camera off after done scanning
                    self.isPresentingScanner = false
                }
                
            }
            
        )
    }
    
    var body: some View {
        //now use VStack to vertically place views inside
        //set up spacing
        VStack(spacing: 10){
            Text(scannedCode)
            //a button to enable user to start scanning
            Button("Scan a QR Code"){
                self.isPresentingScanner = true
            }
            .sheet(isPresented: $isPresentingScanner){
                self.scannerSheet
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
