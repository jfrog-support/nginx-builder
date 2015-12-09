FROM nginx

MAINTAINER Uriah L. "uriahl@jfrog.com"

#nginx must run in foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#add our modified port 443 conf + certifcate
ADD ./ssl.conf /etc/nginx/conf.d/artifactory.jf.ssl.conf
ADD ./artifactory.jf.crt /etc/ssl/certs/artifactory.jf.crt
ADD ./artifactory.jf.key /etc/ssl/private/artifactory.jf.key

EXPOSE 80
EXPOSE 443

CMD nginx
