import React from 'react'
import { truncate } from '../../helpers/utils'
import actions from '../../actions'
import { ASSETS_URL } from '../../config/strings'

export const MediaItem = ({ media, dispatch, options, type }) => {
  const { for_preview: preview } = media

  return (
    <div>
      <div className="item-box-image">
          <div className="bg-dark">
            <div
              className="icon-button-play btn-play-media"
              onClick={() => dispatch({ type: actions.player.play, media: media, options: options })}
            />
          </div>
        <img className="image" src={ASSETS_URL + preview.image}/>
      </div>

      <div className="item-box-category">
        <a className="title" href={preview.category_path}> {preview.category_name} </a>
        {preview.stopped_at &&
         <span className="time">
           {duration.inFormat(preview.stopped_at)} / {duration.inFormat(preview.duration)}
         </span>}
      </div>

      <a className="item-box-name" href={preview.path}> {preview.name} </a>

      <div className="item-box-description">
        {truncate(preview.description, 110) }
      </div>

      <div className="item-box-description list-view">
        {preview.description}
      </div>
    </div>
  )
}