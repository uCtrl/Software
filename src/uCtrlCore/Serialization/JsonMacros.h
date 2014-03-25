#ifndef JSONMACROS_H
#define JSONMACROS_H

#include "json/json.h"

#define UCTRL_JSON(CLASS_NAME)                                      \
public:                                                             \
    json::Object    toObject() const                                \
    {                                                               \
        json::Object obj;                                           \
        fillObject(obj);                                            \
        return obj;                                                 \
    }                                                               \
                                                                    \
    json::Object    toObjectSummary() const                         \
    {                                                               \
        json::Object obj;                                           \
        fillObjectSummary(obj);                                     \
        return obj;                                                 \
    }                                                               \
    void            fillObject(json::Object& obj) const;            \
    void            fillObjectSummary(json::Object& obj) const;     \
    std::string     serialize(bool summary = false) const {         \
        json::Object obj;                                           \
        if (summary) {                                              \
            fillObjectSummary(obj);                                 \
        }                                                           \
        else {                                                      \
            fillObject(obj);                                        \
        }                                                           \
                                                                    \
        return json::Serialize(obj);                                \
    }                                                               \
    void            fillMembers(const json::Object& obj);           \
    void            deserialize(const json::Object& obj)            \
    {                                                               \
        this->fillMembers(obj);                                      \
    }                                                               \





#define BEGIN_DECLARE_JSON_CLASS(NAME, PARENT_DECLARATION, ARGS)    \
class NAME PARENT_DECLARATION                                       \
{                                                                   \
public:                                                             \
    NAME();                                                         \
    json::Object    ToObject() const                                \
    {                                                               \
        json::Object obj;                                           \
        FillObject(obj);                                            \
        return obj;                                                 \
    }                                                               \
                                                                    \
    json::Object    ToObjectSummary() const                         \
    {                                                               \
        json::Object obj;                                           \
        FillObjectSummary(obj);                                     \
        return obj;                                                 \
    }                                                               \
    void            FillObject(json::Object& obj) const;            \
    void            FillObjectSummary(json::Object& obj) const;     \
    std::string     Serialize(bool summary = false) const {         \
        json::Object obj;                                           \
        if (summary) {                                              \
            FillObjectSummary(obj);                                 \
        }                                                           \
        else {                                                      \
            FillObject(obj);                                        \
        }                                                           \
                                                                    \
        return json::Serialize(obj);                                \
    }                                                               \
    void            FillMembers(const json::Object& obj);           \
    static NAME     Deserialize(const json::Object& obj)            \
    {                                                               \
        NAME o;                                                     \
        o.FillMembers(obj);                                         \
        return o;                                                   \
    }                                                               \
    void            deserialize(const json::Object& obj)            \
{                                                               \
    this->FillMembers(obj);                                      \
}                                                               \
                                                                    \
    ARGS

#define END_DECLARE_JSON_CLASS() };

#define DECLARE_JSON_CLASS(NAME, PARENT_DECLARATION, ARGS) \
    BEGIN_DECLARE_JSON_CLASS(NAME, PARENT_DECLARATION, ARGS) \
    END_DECLARE_JSON_CLASS()

#define DECLARE_CLASS_ARGS1(ARG1TYPE, ARG1NAME) protected: \
                                                ARG1TYPE m_##ARG1NAME; \
                                                public: \
                                                const ARG1TYPE& get##ARG1NAME() const { return m_##ARG1NAME; } \
                                                void set##ARG1NAME(const ARG1TYPE& ARG1NAME) { m_##ARG1NAME = ARG1NAME; }
#define DECLARE_CLASS_ARGS2(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME) \
    DECLARE_CLASS_ARGS1(ARG1TYPE, ARG1NAME) \
    DECLARE_CLASS_ARGS1(ARG2TYPE, ARG2NAME)
#define DECLARE_CLASS_ARGS3(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME) \
    DECLARE_CLASS_ARGS2(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME) \
    DECLARE_CLASS_ARGS1(ARG3TYPE, ARG3NAME)
#define DECLARE_CLASS_ARGS4(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME) \
    DECLARE_CLASS_ARGS3(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME) \
    DECLARE_CLASS_ARGS1(ARG4TYPE, ARG4NAME)
#define DECLARE_CLASS_ARGS5(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME) \
    DECLARE_CLASS_ARGS4(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME) \
    DECLARE_CLASS_ARGS1(ARG5TYPE, ARG5NAME)
#define DECLARE_CLASS_ARGS6(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME) \
    DECLARE_CLASS_ARGS5(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME) \
    DECLARE_CLASS_ARGS1(ARG6TYPE, ARG6NAME)

#define DECLARE_JSON_CLASS_ARGS0(NAME) \
    DECLARE_JSON_CLASS(NAME, , )
#define DECLARE_JSON_CLASS_ARGS1(NAME, ARG1TYPE, ARG1NAME) \
    DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS1(ARG1TYPE, ARG1NAME))
#define DECLARE_JSON_CLASS_ARGS2(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME) \
    DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS2(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME))
#define DECLARE_JSON_CLASS_ARGS3(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME) \
    DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS3(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME))
#define DECLARE_JSON_CLASS_ARGS4(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME) \
    DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS4(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME))
#define DECLARE_JSON_CLASS_ARGS5(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME) \
    DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS5(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME))
#define DECLARE_JSON_CLASS_ARGS6(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME) \
    DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS6(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME))

#define BEGIN_DECLARE_JSON_CLASS_ARGS0(NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , )
#define BEGIN_DECLARE_JSON_CLASS_ARGS1(NAME, ARG1TYPE, ARG1NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS1(ARG1TYPE, ARG1NAME))
#define BEGIN_DECLARE_JSON_CLASS_ARGS2(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS2(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME))
#define BEGIN_DECLARE_JSON_CLASS_ARGS3(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS3(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME))
#define BEGIN_DECLARE_JSON_CLASS_ARGS4(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS4(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME))
#define BEGIN_DECLARE_JSON_CLASS_ARGS5(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS5(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME))
#define BEGIN_DECLARE_JSON_CLASS_ARGS6(NAME, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, , DECLARE_CLASS_ARGS6(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME))

#define DECLARE_PARENT(PARENT) : public PARENT

#define DECLARE_JSON_CHILD_CLASS_ARGS0(NAME, PARENT) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT),)
#define DECLARE_JSON_CHILD_CLASS_ARGS1(NAME, PARENT, ARG1TYPE, ARG1NAME) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS1(ARG1TYPE, ARG1NAME))
#define DECLARE_JSON_CHILD_CLASS_ARGS2(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS2(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME))
#define DECLARE_JSON_CHILD_CLASS_ARGS3(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS3(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME))
#define DECLARE_JSON_CHILD_CLASS_ARGS4(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS4(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME))
#define DECLARE_JSON_CHILD_CLASS_ARGS5(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS5(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME))
#define DECLARE_JSON_CHILD_CLASS_ARGS6(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME) \
    DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS6(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME))

#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS0(NAME, PARENT) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT),)
#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS1(NAME, PARENT, ARG1TYPE, ARG1NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS1(ARG1TYPE, ARG1NAME))
#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS2(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS2(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME))
#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS3(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS3(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME))
#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS4(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS4(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME))
#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS5(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS5(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME))
#define BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS6(NAME, PARENT, ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME) \
    BEGIN_DECLARE_JSON_CLASS(NAME, DECLARE_PARENT(PARENT), DECLARE_CLASS_ARGS6(ARG1TYPE, ARG1NAME, ARG2TYPE, ARG2NAME, ARG3TYPE, ARG3NAME, ARG4TYPE, ARG4NAME, ARG5TYPE, ARG5NAME, ARG6TYPE, ARG6NAME))

#endif // JSONMACROS_H
