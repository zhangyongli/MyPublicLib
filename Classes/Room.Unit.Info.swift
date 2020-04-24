//
//  Room.Unit.Info.swift
//  Cuddle
//
//  Created by Marry on 2019/9/25.
//  Copyright © 2019 Guru. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Room.Unit {
    struct Room {
        
        let bag = DisposeBag()
        let roomID: String
        let info = BehaviorRelay<Entity.Livecast.Room?>(value: nil)
        
        init(roomID: String) {
            self.roomID = roomID
        }
        
        /// 获取最新的roomInfo
        func updateInfo() {
            Request.Livecast.Live
                .rooms(roomID: roomID)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { room in
                    self.info.accept(room.first)
                }).disposed(by: bag)
        }
        
    }
}
