import React from 'react'
import Form from 'react-formal'
import { MavMenu } from './common/NavMenu'
import actions from '../actions'
import { feedbackSchema } from '../helpers/schemas'
import { connect } from 'react-redux'
import { BreadCrumbs } from './common/BreadCrumbs'

export const ContactUs = connect(s => ({ feedback: s.feedback }))
(({ dispatch, feedback }) => {

  const handleSubmit = value =>
    dispatch({ type: actions.feedback.save.request, value })

  const handleUpdate = value =>
    dispatch({ type: actions.feedback.update, value })

  const handleErrors = errors =>
    dispatch({ type: actions.feedback.update, value: { errors } })

  return (
    <div className="static-page contactus">
      <div className="header-page">

        <BreadCrumbs items={[
          { to: '/', title: 'Home' },
          { title: 'Contact us' }
        ]}/>

      </div>

      <MavMenu active='contactus'/>

      <div className="left-right-offset">
        <h1>Feel free to contact us about anything.</h1>
        <span>Hopefully its related to what we do of course, but we’re happy to chat.</span>

        <Form
          className="site-form"
          schema={feedbackSchema}
          errors={feedback.errors}
          onError={handleErrors}
          onSubmit={handleSubmit}
          value={feedback}
          onChange={handleUpdate}
        >
          <div className="input-parent">
            <Form.Field
              name='name'
              placeholder='Name'
              className="field"
            />
            { feedback.submitted && <Form.Message for='name'/>}
          </div>
          <div className="input-parent">
            <Form.Field
              name='email'
              placeholder='Email'
              className="field"
            />
            { feedback.submitted && <Form.Message for='email'/>}
          </div>
          <div className="input-parent">
            <Form.Field
              name='body'
              placeholder='New Ideas or Feedback?'
              className="field"
              as="textarea"
              rows={4}
            />
            { feedback.submitted && <Form.Message for='body'/>}
          </div>
          <Form.Submit className="btn-submit" type='submit'>Send</Form.Submit>
        </Form>
      </div>
      <div className="info-wrapper">
        <div className="description left-right-offset">
          <div className="logo"/>
          <div className="text">
            Headquartered in Tampa, Florida, our San Diego office takes a very focused approach to online marketing to
            drive lead generation and e-commerce sales. We rarely have to start from scratch with your marketing
            campaigns
            and marketing automation. We try to start where you are now and make it work better and deliver more
            customers. Sometimes it does mean starting over, but often things simply need to work better. This is far
            more
            cost effective than spending six figures just to rebuild the website by guessing what works and what
            doesn’t.
          </div>
        </div>
        <div className="adress-wrapper left-right-offset">
          <div className="location">
            <div className="title">United States</div>
            <div className="office-wrapper">
              <div className="office">
                <div className="adress">Tampa, Florida</div>
                <div className="details">Phone: 813.344.2520</div>
              </div>
              <div className="office">
                <div className="adress">Southern California</div>
                <div className="details">Phone: 310.872.7653</div>
              </div>
              <div className="office">
                <div className="adress">Washington, DC</div>
                <div className="details">Phone: 703.829.5162</div>
              </div>
            </div>
          </div>
          <div className="location">
            <div className="title">Europe</div>
            <div className="office-wrapper">
              <div className="office">
                <div className="adress">United Kingdom</div>
                <div className="details">Swindon, Wiltshire, SN5</div>
                <div className="details">United KingdomSN5</div>
                <div className="details">Phone: +44 (0)1793 325420</div>
              </div>
              <div className="details">
                Email: &nbsp;
                <a href='mailto:info@clicklaboratory.com'>info@clicklaboratory.com</a>
              </div>
              <div className="details">Twitter: @well_optimized</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
})