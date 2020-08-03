import React from 'react'
import { Link } from 'react-router-dom'
import sanitizeHtml from 'sanitize-html'
import Moment from 'react-moment'
import {
  LabelIcon
} from '../icons'

import { readableColor } from 'polished'

window.readableColor = readableColor

export function textColor (color) {
  const lightReturnColor = '#121212'
  const darkReturnColor = '#f3f3f3'
  return readableColor(color, lightReturnColor, darkReturnColor)
}

export default function ConversationItemList ({ app, conversation }) {
  const renderConversationContent = (o) => {
    const message = o.lastMessage.message
    if (message.htmlContent) {
      return sanitizeHtml(message.htmlContent).substring(0, 250)
    }
  }

  const user = conversation.mainParticipant
  const message = conversation.lastMessage
  const participant = conversation.mainParticipant
  const appUser = message.appUser
  const tags = conversation.tagList

  function tagColor (tag) {
    const defaultColor = {
      bgColor: '#fed7d7',
      color: textColor('#fed7d7')
    }

    if (!app.tagList) return defaultColor

    const findedTag = app.tagList.find(
      (o) => o.name === tag
    )

    if (!findedTag) return defaultColor

    const newColor = findedTag.color

    return {
      bgColor: newColor,
      color: textColor(newColor)
    }
  }

  function renderTag (tag) {
    const color = tagColor(tag)
    return <span key={`conversation-${conversation.key}-tag-${tag}`}
      style={{
        backgroundColor: color.bgColor,
        color: color.color
      }}
      className="inline-block bg-red-200 rounded-full px-2 py-1 text-xs font-semibold text-gray-700 mr-2">
      #{tag}
    </span>
  }

  return (
    <Link
      to={`/apps/${app.key}/conversations/${conversation.key}`}
      className="block hover:bg-gray-100 focus:outline-none focus:bg-gray-100 transition duration-150 ease-in-out"
    >
      <div className="px-6 py-4 whitespace-no-wrap border-b border-gray-200 ">
        <div className="flex items-center">
          <div className="flex-shrink-0 h-10 w-10">
            <img
              className="h-10 w-10 rounded-full"
              src={user.avatarUrl}
              alt={user.displayName}
            />
          </div>

          <div className="ml-4 truncate w-full">

            <div className="flex justify-between">
              <span className="text-md leading-5 font-semibold text-gray-800">
                {user.displayName}
              </span>

              <span className="text-xs leading-5 font-light text-gray-300">
                <Moment fromNow ago>
                  {message.createdAt}
                </Moment>
              </span>
            </div>

            <div className="text-sm leading-5 text-gray-500 flex pb-2 pt-1">
              {appUser && appUser.id !== participant.id && (
                <img
                  alt={appUser.displayName}
                  className="rounded-full h-5 w-5 self-start mr-2"
                  src={appUser.avatarUrl}
                />
              )}

              {message.privateNote &&
                <span className="mr-2">
                  <LabelIcon/>
                </span>
              }

              <span
                dangerouslySetInnerHTML={{
                  __html: renderConversationContent(conversation)
                }}
              />
            </div>

            {
              tags.map((o) =>
                renderTag(o)
              )
            }

          </div>
        </div>
      </div>
    </Link>
  )
}
