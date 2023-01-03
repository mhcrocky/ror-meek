import React from 'react'
import { truncate } from '../../helpers/utils'
import { ASSETS_URL } from '../../config/strings'

export const BlogItem = ({media, type}) => {
  const { for_preview: preview } = media
  return (
    <div>
      <div className='item-box-image'>
        <a className='link' href={preview.path} target={type=='posts' ? '_blank' : ''}>
          <img className='image' src={ASSETS_URL + preview.image}/>
        </a>
      </div>

      <div className='item-box-category'>
        <a className='title' href={preview.category_path}> {preview.category_name} </a>
      </div>

      <a className='item-box-name' href={preview.path} target={type=='posts' ? '_blank' : ''}>
        {preview.name}
      </a>

      <div className='item-box-description'>
        {truncate(preview.description, 110) }
      </div>

      <div className='item-box-description list-view'>
        {preview.description}
      </div>
    </div>
  )
}
