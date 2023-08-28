//
//  LoginView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

import SwiftUI

struct LoginView: View {
    
    
    @State var email = ""
    @State var password = ""
    @State var showPassword:Bool = false
    @EnvironmentObject var mainviewM:MainViewViewModel
    var loginvm = LoginViewModel()
    @State var showLocalAlert:Bool = false
    @State var alertMessage:String = ""
    var body: some View {
        ZStack{
            Color.green
                    .edgesIgnoringSafeArea(.all)
           
            VStack{
                Spacer()
                Text("Log In")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                    .padding(5)
                    .foregroundColor(.black)
                
                Spacer()
                
                
                
                TextField(text:$email){
                    Text("Enter Email")
                }.padding()
                    .textInputAutocapitalization(.never)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipped()
                    .cornerRadius(10)
                
                HStack{
                    if showPassword {
                        TextField(text:$password){
                            Text("Enter Password")
                        }.padding()
                            .textInputAutocapitalization(.never)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipped()
                            .cornerRadius(10)
                    }else{
                        SecureField(text:$password){
                            Text("Enter Password")
                        }.padding()
                            .textInputAutocapitalization(.never)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipped()
                            .cornerRadius(10)
                    }
                    Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                }.background(Color.white)
                    .clipped()
                    .cornerRadius(10)
                
               
                
                    
                
                Spacer()
                
                Button {
                    //
                    Task{
                        let resp = await loginvm.loginUser(email: email, password: password)
                        if resp.current {
                            mainviewM.setUserLoggedIn(status: true)
                            mainviewM.setLoggedInUserId(userId: resp.userId)
                           
                        }else{
                            alertMessage = "Email or Password is incorrect!"
                            showLocalAlert.toggle()
                            
                        }
                    }
                } label: {
                    Text("Submit")
                }.padding()
                    .frame(width: 350)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .clipped()
                    .cornerRadius(10)
                
                NavigationLink{
                    SignupView()
                }label: {
                    Text("New user? Register")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
    
            }.padding()
                .alert(isPresented: $showLocalAlert, content: getAlert)
            
                
        }.navigationBarHidden(true)
       
    }
    func getAlert() -> Alert {
            return Alert(title: Text(alertMessage))
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }.environmentObject(MainViewViewModel())
       
    }
}
