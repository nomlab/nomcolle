# -*- coding: utf-8 -*-
class BooksController < ApplicationController

  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def lend
    @book = Book.find_by_id(params[:id])

    case @book.status
    when 3 #貸し出し可能
      @book.update_attributes(:status => "4")
      flash[:notice] = "#{@book.title} を借りました．"
    else #それ以外
      flash[:error] = "failed"
    end
    redirect_to :action => "index"
  end

  def return
    @book = Book.find_by_id(params[:id])

    case @book.status
    when 4 #貸し出し中
      @book.update_attributes(:status => "3")
      flash[:error] = "#{@book.title} を返却しました．"
    else #それ以外
      flash[:error] = "failed"
    end

    redirect_to request.referer
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :ok }
    end
  end

  def new_from_isbn
    @book = Book.new
   
    respond_to do |format|
      format.html      
      format.json { render json: @book }
    end
  end

  def new_from_plural_isbn
    @book = Book.new

    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end

  def create_from_isbn 
    @book = Book.create({:isbn13 => params[:isbn]})

    respond_to do |format|
      unless @book.id == nil
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new_from_isbn" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from_plural_isbn
    @book = Book.new
    count_before = Book.count
    isbns = []
    created_books_id = []
    flag = true
    params[:plural_isbn].each_line do |isbn|
      isbn.chomp!
      isbns << {:isbn13 => isbn} unless  isbn == ""
    end

    if isbns.size == 0
      @book.errors.add(:isbn, "is not inputted")
      flag = false
    end
 
    begin
      Book.transaction do
        isbns.each do |isbn|
          book = Book.create(isbn)
          if book.id == nil
            raise ActiveRecord::RecordInvalid.new(book)
          end
        end
      end

    rescue
      flag = false
      @book.errors.add(:isbn, "is not currect")
    end

    respond_to do |format|
      if flag
        format.html { redirect_to books_url, notice: "#{Book.count - count_before} books was registered." }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new_from_plural_isbn" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
    
end
