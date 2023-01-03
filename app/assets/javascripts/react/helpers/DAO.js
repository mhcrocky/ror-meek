export const feedbackDAO = ({ name, email, body }) =>
  ({ feedback: { name, email, body } })

export const userSignupDAO = ({ email, password, password_confirmation, first_name, last_name }) =>
  ({ email, password, password_confirmation, first_name, last_name })
