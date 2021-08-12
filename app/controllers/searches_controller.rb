class SearchesController < ApplicationController
  def show
    @categories = Category.all
    
    @subcategories1 = Subcategory.where(category_id: 1)
    @sub1 = '"サブカテゴリーを選択..."'
    @subcategories1.each do |sub|
      item = ',"' + sub.name + '"'
      @sub1 = @sub1 + item
    end
    
    @subcategories2 = Subcategory.where(category_id: 2)
    @sub2 = '"サブカテゴリーを選択..."'
    @subcategories2.each do |sub|
      item = ',"' + sub.name + '"'
      @sub2 = @sub2 + item
    end
    
    @subcategories3 = Subcategory.where(category_id: 3)
    @sub3 = '"サブカテゴリーを選択..."'
    @subcategories3.each do |sub|
      item = ',"' + sub.name + '"'
      @sub3 = @sub3 + item
    end
    
    @subcategories4 = Subcategory.where(category_id: 4)
    @sub4 = '"サブカテゴリーを選択..."'
    @subcategories4.each do |sub|
      item = ',"' + sub.name + '"'
      @sub4 = @sub4 + item
    end
    
    #@subcategories5 = Subcategory.where(category_id: 5)
    #@sub5 = '"サブカテゴリーを選択..."'
    #@subcategories5.each do |sub|
    #  item = ',"' + sub.name + '"'
    #  @sub5 = @sub5 + item
    #end
  end
  
  def index
    @communities = Community.all
  end
  
end