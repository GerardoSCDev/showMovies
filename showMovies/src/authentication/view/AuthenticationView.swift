//
//  AuthenticationView.swift
//  showMovies
//
//  Created by Gerardo Santillan on 15/03/25.
//
import SwiftUI

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    
                    VStack {
                        Image("backgroundAutenticator")
                            .resizable()
                            
                    }
                    
                    VStack {
                        Text("Show Movies")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        TextField("Email", text: $viewModel.user.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .onChange(of: viewModel.user.email) { oldValue, newValue in
                                viewModel.validateForm()
                            }
                        
                        SecureField("Password", text: $viewModel.user.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .onChange(of: viewModel.user.password) { oldValue, newValue in
                                viewModel.validateForm()
                            }
                        Spacer()
                        Text(viewModel.badAuthentication ? "Usuario o contraseña incorrectos" : "")
                            .font(.title3)
                            .foregroundColor(.white)
                        Button {
                            if viewModel.hasUser {
                                viewModel.loginUser()
                            } else {
                                viewModel.saveUser()
                                viewModel.goToListMovies = true
                            }
                        } label: {
                            Text(viewModel.hasUser ? "Ingresar" :"Registrate")
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .foregroundStyle(viewModel.disabledButton ? Color.white.opacity(0.5) : .white)
                        }
                        .buttonStyle(.bordered)
                        .disabled(viewModel.disabledButton)
                        
                        Spacer()
                        
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                
            }
            .task {
                viewModel.verifyExistUser()
            }
            .navigationDestination(isPresented: $viewModel.goToListMovies) {
                ListMoviesView()
            }
            
        }
        
    }
}

#Preview {
    AuthenticationView()
}
