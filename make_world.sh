#!/bin/sh

rails generate scaffold Book \
    title:string \
    author:string \
    publisher:string \
    isbn13:string \
    price:integer \
    page:integer \
    width:integer \
    height:integer \
    depth:integer \
    image_id:integer \
    status:integer

rails generate scaffold User \
    name:string \
    login_name:string \
    password:string \
    description:string

rails generate scaffold History \
    book:references \
    user:references \
    action:integer

rails generate scaffold Review \
    book:references \
    user:references \
    description:text \
    stars:integer

rails generate scaffold SubscriptionRequest \
    book:references \
    user:references \
    description:text

rails generate scaffold Image \
    book:references \
    path:string
