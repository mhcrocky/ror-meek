import React from 'react'
import Form from 'react-formal'
import actions from '../../actions'
import { signupSchema } from '../../helpers/schemas'
import { connect } from 'react-redux'
import { Link } from '../common/Link'

export const SignupForm = connect(s => ({ user: s.user }))
(({ dispatch, user }) => {

  const handleSubmit = value => dispatch({ type: actions.user.signup.request, value })

  const handleUpdate = value => dispatch({ type: actions.user.update, value })

  const handleErrors = errors => dispatch({ type: actions.user.update, value: { errors } })

  return (
    <Form
      className="site-form"
      schema={signupSchema}
      errors={user.errors}
      onError={handleErrors}
      onSubmit={handleSubmit}
      value={user}
      onChange={handleUpdate}
    >
      <hr className="separator"/>
      <div className="title text-support uppercase">Create New Account</div>
      <a className="btn-facebook" href="/api/users/auth/facebook" target="_self">
        facebook</a>
      <a className="btn-twitter" href="/api/users/auth/twitter" target="_self">
        twitter</a>
      <hr className="separator"/>
      <div className="title text-support">or</div>
      <div className="input-parent">
        {user.submitted && <Form.Message for='email'/>}
        <Form.Field
          name='email'
          placeholder='Email'
          className="field landing-page-field"
        />
      </div>
      <div className="input-parent">
        {user.submitted && <Form.Message for='first_name' />}
        <Form.Field
          name='first_name'
          placeholder='First Name'
          className="field landing-page-field"
        />
      </div>
      <div className="input-parent">
        {user.submitted && <Form.Message for='last_name' />}
        <Form.Field
          name='last_name'
          placeholder='Last Name'
          className="field landing-page-field"
        />
      </div>
      <div className="input-parent">
        {user.submitted && <Form.Message for='password'/>}
        <Form.Field
          name='password'
          placeholder='Password'
          type='password'
          className="field landing-page-field"
        />
      </div>
      <div className="input-parent">
        {user.submitted && <Form.Message for='password_confirmation'/>}
        <Form.Field
          name='password_confirmation'
          type='password'
          placeholder='Password Confirmation'
          className="field landing-page-field"
        />
      </div>
      <Form.Submit className="btn-submit" type='submit'>Sign up</Form.Submit>
      <div className="info text-support">
        By creating an account, you are agreeing to
        <Link to='/terms'> Meek Terms of Service</Link>
      </div>
    </Form>
  )
})