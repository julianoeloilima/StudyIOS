//
//  ViewController.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 06/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doLoginEasyRest() {
        
        userName!.text = "julianoeloilima@yahoo.com.br"
        userPass!.text = "abc123456"

        LoginService().doLogin(userName: userName!.text!, userPassword: userPass!.text!,
                               onSuccess: {
                                response in
                                
            self.performSegue(withIdentifier: "goToViewTasks", sender: self)

         
        }, onError: { (err) in
         
            var errorCode = 0
            if err != nil && err?.httpResponseCode != nil {
                errorCode = err!.httpResponseCode!
            }
         
            let alert = UIAlertController(title: "Erro",
                                          message: "Houve algum problema \(errorCode)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
         
        }, always: {
            //hide loading
        })
    }
    
    func getRequest() {
        //show loading
        PostService().getPosts(onSuccess: { response in
            
            let alert = UIAlertController(title: "OK", message: "Sucesso \(response)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }, onError: { _ in
            let alert = UIAlertController(title: "Erro",
                                          message: "Houve algum problema", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }, always: {
            //hide loading
        })
        
    }
    

    @IBAction func doLogin(_ sender: UIButton) {

        doLoginEasyRest()
        
        //getRequest()
        
        /*
        let url = URL(string: "http://localhost:8000/api/oauth/token/")!
        
        var params : [String : Any] = [String : Any]()
        params["client_id"] = "Wmn70AihcBAJyRqAv9PEopgk7fzuwZUDJA4SyA2P"
        params["client_secret"] = "QJjXb9ZrHHHge4dRlQ3YsI6uRri4gsXl9CZyd6gbSMMecnTc1KPaUS9ZfSQtoQX2xxxnn2OPhvMgcrWHSCwLH08fO31hM11vxYCWQoCWR4Zu9wGXV3oBPifcTvVbmH5d"
        params["grant_type"] = "password"
        params["username"] = userName.text!
        params["password"] = userPass.text!
        
        
        
        Alamofire.request(url, method: .post, parameters: params , encoding: JSONEncoding(), headers: nil)
            .responseJSON { response in
         
                let code = response.response?.statusCode
         
         
                switch response.result {
                case .failure(let err):
                    let alert = UIAlertController(title: "Erro", message: "Ocorreu uma falha ao realizar a autenticação.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
/*
                     self.posts = []
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
 */
                    return
                case .success(let json):
         
                    print(json)
         
                    let loginInfo = (try? JSONDecoder().decode(Login.self, from: response.data!)) ?? nil

                    if loginInfo != nil {
                        let alert = UIAlertController(title: "OK", message: "Sucesso \(response.data)", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let loginError : LoginError? = (try? JSONDecoder().decode(LoginError.self, from: response.data!)) ?? nil
                        if loginError != nil {
                            let alert = UIAlertController(title: "OK", message: "Erro \(loginError!.error_description)", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else {
                            let alert = UIAlertController(title: "OK", message: "Erro!!!", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
         
         

         
                    //DispatchQueue.main.async {
                    //    self.tableView.reloadData()
                    //}
                }
                
        }
 */
    }
    
}

