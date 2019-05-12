export const APPS = `
query Apps{
  apps{
    key
    name
  }  
}
`

export const APP = `
query App($appKey: String!){
  app(key: $appKey) {
      encryptionKey
      key
      name
      preferences
      segments {
        name
        properties
      }
      state
      tagline
    }
}
`
export const CONVERSATIONS = `
  query App($appKey: String!, $page: Int!){
    app(key: $appKey) {
      encryptionKey
      key
      name
      conversations(page: $page){
        collection{
          id
          state
          readAt
          lastMessage{
            source
            message
            messageSource{
              id
              type
            }
            appUser {
              id
              email
              properties
            }
          }
          mainParticipant{
            id
            email
            properties
          }
        }
        meta

      }
    }
  }
`

export const CONVERSATION=`
  query App($appKey: String!, $id: Int!, $page: Int){
    app(key: $appKey) {
      encryptionKey
      key
      name
      conversation(id: $id){
        id
        state 
        readAt
        mainParticipant{
          id
          email
          properties
        }
        
        messages(page: $page){
          collection{
            message
            source
            readAt
            appUser{
              email
              properties
            }
            source
            messageSource {
              name
              state
              fromName
              fromEmail
              serializedContent
            }
            emailMessageId
          }
          meta
        }
    }
  }
}

`

export const CURRENT_USER = `
  query CurrentUser {
    userSession {
      email
    }
  }
`

export const APP_USER = `
query AppUser($appKey: String!, $id: Int! ) {
  app(key: $appKey) {
    appUser(id: $id ) {
      email
      lastVisitedAt
      referrer
      state
      ip
      city
      region
      country
      lat
      lng
      postal
      webSessions
      timezone
      browser
      browserVersion
      os
      osVersion
      browserLanguage
      lang

    }
  }
}
`