FROM centos:6.6

WORKDIR /root

RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml-devel
RUN yum -y install ImageMagick ImageMagick-devel ipa-pgothic-fonts
RUN yum -y install httpd httpd-devel
RUN yum -y install mysql-server mysql-devel

# ruby
RUN curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz
RUN yum -y install tar
RUN tar xvf ruby-2.1.5.tar.gz
RUN cd ruby-2.1.5 && ./configure --disable-install-doc && make && make install 
RUN gem install bundler --no-rdoc --no-ri

# mysql
ADD my.cnf /etc/my.cnf
ADD redmine.sql /root/
RUN service mysqld start && mysql -u root < /root/redmine.sql

# redmine
RUN curl -O http://www.redmine.org/releases/redmine-2.6.3.tar.gz
RUN tar xvf redmine-2.6.3.tar.gz
RUN mv redmine-2.6.3 /var/lib/redmine
ADD database.yml /var/lib/redmine/config/
ADD configuration.yml /var/lib/redmine/config/
RUN cd /var/lib/redmine && bundle install --without development test --path vendor/bundle
WORKDIR /var/lib/redmine
RUN bundle exec rake generate_secret_token
ENV RAILS_ENV production
RUN service mysqld start && bundle exec rake db:migrate
RUN gem install passenger --no-rdoc --no-ri
RUN passenger-install-apache2-module --auto
ADD passenger.conf /etc/httpd/conf.d/
RUN chown -R apache:apache /var/lib/redmine
ADD httpd.conf /etc/httpd/conf/httpd.conf

EXPOSE 80

ENTRYPOINT service mysqld start && service httpd start && /bin/bash --login

