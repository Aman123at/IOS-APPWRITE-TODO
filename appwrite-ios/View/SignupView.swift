//
//  SignupView.swift
//  appwrite-ios
//
//  Created by Aman Tiwari on 26/08/23.
//

import SwiftUI

struct SignupView: View {
    //dismiss a view
    @Environment(\.presentationMode) var presentationMode
    @State var userName = ""
    @State var email = ""
    @State var password = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var showPassword:Bool = false
    let appwriteService = AppwriteService()
    let signupvm = SignUpViewModel()
    @EnvironmentObject  var mainviewM:MainViewViewModel

    var body: some View {
        ZStack{
            Color.green
                    .edgesIgnoringSafeArea(.all)
           
            VStack{
                Spacer()
                Text("Sign Up")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                    .padding(5)
                    .foregroundColor(.black)
                
                Spacer()
                
                TextField(text:$userName){
                    Text("Enter User Name")
                }.padding()
                    .textInputAutocapitalization(.never)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipped()
                    .cornerRadius(10)
                
                TextField(text:$email){
                    Text("Enter Email")
                }.padding()
                    .textInputAutocapitalization(.never)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipped()
                    .cornerRadius(10)
                HStack{
                    if showPassword{
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
                    if textIsValid(){
                        //
                        Task{
                            
                                let resp = await signupvm.registerUser(email:email,password:password,name:userName)
                            
                            if resp {
                                presentationMode.wrappedValue.dismiss()
                               
                            }
                           
                           
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
                    LoginView()
                }label: {
                    Text("Already a user? Sign In")
                        .foregroundColor(.black)
                }
                
                
                Spacer()
 
                
            }.padding()
                
        }
        .alert(isPresented: $showAlert, content: getAlert)
        .navigationBarHidden(true)
    }
    
    
    func textIsValid() -> Bool {
            if userName.count < 3 {
                alertTitle = "Username contains atleast 3 characters 😟"
                showAlert.toggle()
                return false
            }else if email.count < 3{
                alertTitle = "Email contains atleast 3 characters 😟"
                showAlert.toggle()
                return false
            }else if password.count < 6{
                alertTitle = "Password contains atleast 6 characters 😟"
                showAlert.toggle()
                return false
            }
            return true
        }
        
        func getAlert() -> Alert {
            return Alert(title: Text(alertTitle))
        }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignupView()
        }.environmentObject(MainViewViewModel())
            
        
      
    }
}
