class SearchesController < ApplicationController
  def show
    @categories = Category.all
    
    @subcategories1 = Subcategory.where(category_id: 1)
    @sub1 = '"---"'
    @sub1_id = '""'
    @subcategories1.each do |sub|
      item = ',"' + sub.name + '"'
      @sub1 = @sub1 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub1_id = @sub1_id + item_id
    end
      
    @subcategories2 = Subcategory.where(category_id: 2)
    @sub2 = '"---"'
    @sub2_id = '""'
    @subcategories2.each do |sub|
      item = ',"' + sub.name + '"'
      @sub2 = @sub2 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub2_id = @sub2_id + item_id
    end
    
    @subcategories3 = Subcategory.where(category_id: 3)
    @sub3 = '"---"'
    @sub3_id = '""'
    @subcategories3.each do |sub|
      item = ',"' + sub.name + '"'
      @sub3 = @sub3 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub3_id = @sub3_id + item_id
    end
    
    @subcategories4 = Subcategory.where(category_id: 4)
    @sub4 = '"---"'
    @sub4_id = '""'
    @subcategories4.each do |sub|
      item = ',"' + sub.name + '"'
      @sub4 = @sub4 + item
      item_id = ',"' + sub.id.to_s + '"'
      @sub4_id = @sub4_id + item_id
    end
  end
  
  def index
    @communities = Community.all
  end
end