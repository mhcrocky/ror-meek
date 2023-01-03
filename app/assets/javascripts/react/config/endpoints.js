import { API_URL } from './strings'

export const API = {
  staticPages: slug => `${API_URL}/static_pages/${slug}`,
  landingPages: slug => `${API_URL}/landing_pages/${slug}`,
  feedback: `${API_URL}/feedback`,
  searches: (query, type, page = 1) => `${API_URL}/search/searches?format=json&page=${page}&search=${query}&type=${type}`,
  backgrounds: name => `${API_URL}/backgrounds/${name}`,
  trends: kind => `${API_URL}/trends/${kind}`,
  play: `${API_URL}/play`,
  categories: `${API_URL}/categories`,
  category: slug => `${API_URL}/categories/${slug}`,
  recent: `${API_URL}/user/recent/recent_episodes`
}
