import React from 'react'
import { MavMenu } from './common/NavMenu'
import { BreadCrumbs } from './common/BreadCrumbs'

export const Cookies = () =>
  <div className="static-page cookies">
    <div className="header-page">

      <BreadCrumbs items={[
        { to: '/', title: 'Home' },
        { title: 'What are Cookies' }
      ]}/>

      <div className="categories">
        Click Laboratory, LLC.
      </div>
      <h1 className="title">
        What are Cookies
      </h1>
      <div className="info">
        <a className="icon-link" href='http://www.clicklaboratory.com/' target='_blank'>
          http://www.clicklaboratory.com/</a>
      </div>
    </div>
    <MavMenu active='cookies'/>
    <div className="left-right-offset">
      <h2>WHAT ARE COOKIES</h2>
      <p>As is common practice with almost all professional websites this site uses cookies, which are tiny files that
        are downloaded to your computer, to improve your experience. This page describes what information they gather,
        how we use it and why we sometimes need to store these cookies. We will also share how you can prevent these
        cookies from being stored however this may downgrade or ‘break’ certain elements of the site's
        functionality.</p>
      <p>For more general information on cookies see the Wikipedia article on HTTP Cookies.</p>
      <h2>HOW WE USE COOKIES</h2>
      <p>We use cookies for a variety of reasons detailed below. Unfortunately, in most cases, there are no industry
        standard options for disabling cookies without completely disabling the functionality and features they add to
        this site. It is recommended that you leave on all cookies if you are not sure whether you need them or not in
        case they are used to provide a service that you use.</p>
      <h2>DISABLING COOKIES</h2>
      <p>You can prevent the setting of cookies by adjusting the settings on your browser (see your browser Help for
        how to do this). Be aware that disabling cookies will affect the functionality of this and many other websites
        that you visit. Disabling cookies will usually result in also disabling certain functionality and features of
        this site. Therefore it is recommended that you do not disable cookies.</p>
      <h2>THE COOKIES WE SET</h2>
      <h3>Account related cookies</h3>
      <p>If you create an account with us then we will use cookies for the management of the signup process and
        general administration. These cookies will usually be deleted when you log out however in some cases they may
        remain afterward to remember your site preferences when logged out.</p>
      <h3>Login related cookies</h3>
      <p>We use cookies when you are logged in so that we can remember this fact. This prevents you from having to log
        in every single time you visit a new page. These cookies are typically removed or cleared when you log out to
        ensure that you can only access restricted features and areas when logged in.</p>
      <h3>Email newsletters related cookies</h3>
      <p>This site offers newsletter or email subscription services and cookies may be used to remember if you are
        already registered and whether to show certain notifications which might only be valid to
        subscribed/unsubscribed users.</p>
      <h3>Orders processing related cookies</h3>
      <p>This site offers e-commerce or payment facilities and some cookies are essential to ensure that your order is
        remembered between pages so that we can process it properly.</p>
      <h3>Forms related cookies</h3>
      <p>When you submit data to through a form such as those found on contact pages or comment forms cookies may be
        set to remember your user details for future correspondence.</p>
      <h3>Site preferences cookies</h3>
      <p>In order to provide you with a great experience on this site, we provide the functionality to set your
        preferences for how this site runs when you use it. In order to remember your preferences, we need to set
        cookies so that this information can be called whenever you interact with a page is affected by your
        preferences.</p>
      <h2>Third Party Cookies</h2>
      <p>In some special cases, we also use cookies provided by trusted third parties. The following section details
        which third party cookies you might encounter through this site.</p>
      <p>This site uses Google Analytics which is one of the most widespread and trusted analytics solution on the web
        for helping us to understand how you use the site and ways that we can improve your experience. These cookies
        may track things such as how long you spend on the site and the pages that you visit so we can continue to
        produce engaging content.</p>
      <p>For more information on Google Analytics cookies, see the official Google Analytics page.</p>
      <p>Third party analytics are used to track and measure usage of this site so that we can continue to produce
        engaging content. These cookies may track things such as how long you spend on the site or pages you visit
        which helps us to understand how we can improve the site for you.</p>
      <p>From time to time we test new features and make subtle changes to the way that the site is delivered. When we
        are still testing new features these cookies may be used to ensure that you receive a consistent experience
        whilst on the site whilst ensuring we understand which optimizations our users appreciate the most.</p>
      <p>As we sell products it’s important for us to understand statistics about how many of the visitors to our site
        actually make a purchase and as such this is the kind of data that these cookies will track. This is important
        to you as it means that we can accurately make business predictions that allow us to monitor our advertising
        and product costs to ensure the best possible price.</p>
      <p>The Google AdSense service we use to serve advertising uses a DoubleClick cookie to serve more relevant ads
        across the web and limit the number of times that a given ad is shown to you.</p>
      <p>For more information on Google AdSense see the official Google AdSense privacy FAQ.</p>
      <p>Several partners advertise on our behalf and affiliate tracking cookies simply allow us to see if our
        customers have come to the site through one of our partner sites so that we can credit them appropriately and
        where applicable allow our affiliate partners to provide any bonus that they may provide you for making a
        purchase.</p>
      <p>We also use social media buttons and/or plugins on this site that allow you to connect with your social
        network in various ways. For these to work the following social media sites including; Facebook, Instagram,
        Twitter, YouTube, and LinkedIn, will set cookies through our site which may be used to enhance your profile on
        their site or contribute to the data they hold for various purposes outlined in their respective privacy
        policies.</p>
      <h2>MORE INFORMATION</h2>
      <p>Hopefully, that has clarified things for you and as was previously mentioned if there is something that you
        aren’t sure whether you need or not it’s usually safer to leave cookies enabled in case it does interact with
        one of the features you use on our site.</p>
      <p>
        However, if you are still looking for more information then you can contact us through &nbsp;
        <a href='mailto:info@meek.co'>info@meek.co.</a>
      </p>
    </div>
  </div>
