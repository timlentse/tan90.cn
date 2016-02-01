class FishtripArticle < ActiveRecord::Base

  def self.find_seo_article(params)
    articles = {}
    self.where(params).each do |article|
      if articles[article.type_name]
        articles[article.type_name].push({:title=>article.title,:link=>"/fishtrip/articles/#{article.article_id}/"})
      else
        articles[article.type_name] = [{:title=>article.title,:link=>"/fishtrip/articles/#{article.article_id}/"}]
      end
    end
    articles = find_seo_article_by_country(params[:country]) if articles.empty?
    articles
  end

  def self.find_seo_article_by_country(country)
    articles = {}
    self.where(:country=>country).each do |article|
      if articles[article.type_name]
        articles[article.type_name].push({:title=>article.title,:link=>"/fishtrip/articles/#{article.article_id}/"})
      else
        articles[article.type_name] = [{:title=>article.title,:link=>"/fishtrip/articles/#{article.article_id}/"}]
      end
    end
    articles
  end

end
