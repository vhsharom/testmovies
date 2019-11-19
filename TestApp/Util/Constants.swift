//
//  Size.swift
//  HelloGas
//
//

import Foundation
import UIKit
import CoreLocation

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

let AppFontBold = "Helvetica Bold"
let AppFontNormal = "Helvetica"

let buttonHeight : CGFloat = 44
let buttonCornerSize : CGFloat = 5

let demoMode = false

//API Key (v3 auth)
//bbb5045ac5f8792c20fe23b5b411cfd6
//eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmI1MDQ1YWM1Zjg3OTJjMjBmZTIzYjViNDExY2ZkNiIsInN1YiI6IjVkY2ViYjhiYjc2Y2JiMDAxNjc2ZjE2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.khgE4NSLiQ_jGViQtDyN_hE6ZlW7HbPUKMu5Ni3WM2g
/*
 
https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=bbb5045ac5f8792c20fe23b5b411cfd6
https://api.themoviedb.org/3/discover/movie/?certification_country=US&certification=R&sort_by=vote_average.desc&api_key=bbb5045ac5f8792c20fe23b5b411cfd6
http://api.themoviedb.org/3/movie/upcoming?api_key=bbb5045ac5f8792c20fe23b5b411cfd6
*/
