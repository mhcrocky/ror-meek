import React from 'react'
import { MediaItem } from './MediaItem'
import { deSnakeCased } from '../../helpers/utils'
import { BlogItem } from './BlogItem'

export const SearchedItems = ({ result, type, dispatch, onLoadMore }) => {
  const { collection, nextPage } = result

  if (!collection.length) { return null }

  return (
    <div id="search-block">
      <div className="left-right-offset">
        <h1 className="title">{deSnakeCased(type).toUpperCase()}:</h1>
      </div>
      <div className="left-right-offset">
        <ul className="list-box grid-view">
          {collection.map(media =>
            <li className="list-box-item" key={media.id}>
              {(type=='podcasts' || type=='episodes') ?
                <MediaItem media={media} dispatch={dispatch} type={type}/> :
                <BlogItem media={media} type={type}/>
              }
            </li>
          )}
        </ul>
      </div>
      {nextPage &&
       <div className="left-right-offset">
         <div
           className="btn-load-more"
           onClick={() => onLoadMore(type, nextPage)}
         >
           <span>+</span><span>Load More</span>
         </div>
       </div>}
    </div>
  )
}
