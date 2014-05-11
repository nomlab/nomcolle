# -*- coding: utf-8 -*-
print "以下の例に従って入力してください．\nName    : 岡大 太郎\nUserName: okadai\nPassword: okadaI\n\n"
print "Name    : "; name = gets.chomp
print "UserName: "; login_name = gets.chomp
print "Password: "; pass = gets.chomp
User.create(name: "#{name}", login_name:"#{login_name}", password: "#{pass}")
