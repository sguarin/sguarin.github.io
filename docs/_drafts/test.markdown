---
layout: post
title:  "Using FreeRTOS Tasks over C++ in ESP32"
date:   2020-08-24 00:57:03 -0300
categories: ESP32 FreeRTOS
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

{% highlight c++ %}
class MyWebserver
{
  public:
    bool init(THandlerSetConfigFunction pSetConfigCallback, THandlerGetStatusFunction pGetStatusCallback);
    void loop();
    void run();

  protected:
    static void task(void *pvParameters);

};
{% endhighlight %}

{% highlight c++ %}
  void MyWebserver::task(void *pvParameters)
  {
    MyWebserver* p = static_cast<MyWebserver *>(pvParameters);
    for (;;)
    {   
        p->loop();
        vTaskDelay(10 / portTICK_PERIOD_MS);
    }   
}
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
