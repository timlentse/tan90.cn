class ProxiesController < ApplicationController
  before_action :set_params

  def index
    @page_type='proxy'
    @proxies = HttpProxy.search(@params)
    @tdk=tdk
    @count = HttpProxy.count
  end

  def index_post
    @proxies = HttpProxy.search(@params)
    render 'list.js.erb'
  end

  private

  def set_params
    @params = params.permit(:page)
  end

  def tdk
    {
      :h1=>'http代理',
      :title=>'http免费代理每天更新',
      :keywords=>'http代理,免费代理',
      :description=>'免费提供国内免费的http代理，实时更新。'
    }
  end
end
