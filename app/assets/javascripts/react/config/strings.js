export const IS_DEVELOPMENT = window.__ENV__ === "development";

export const API_URL = "/api";

export const ASSETS_URL = IS_DEVELOPMENT ? "http://localhost:3000" : "";

export const CURRENT_BACKGROUND = "homepage_guest";

export const TRENDS = ["episodes", "latest_episodes", "podcasts_to_try"];

export const SEARCHES = ["podcasts", "episodes", "posts", "articles"];

export const ERRORS = {
  MEDIA: "Media error",
  SEARCH_NO_RESULTS: "Sorry, no results.",
  PASSWORD_CONFIRMATION: "Password confirmation does not match",
};

export const TAG_SIGNUP = "##SIGNUP##";

export const LOCAL_STORAGE = {
  VIEW_MODE: "ngStorage-itemView",
};

export const VIEW_MODES = {
  LIST: "list-view",
  GRID: "grid-view",
};
