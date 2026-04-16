#!/bin/bash
# Create AI Venture Builder Masterclass deck via Gamma API

API_KEY="sk-gamma-VuUCX1TCHGRWE2c4299WjfkaFau9khMfAhnzDF7WA"
BASE="https://public-api.gamma.app/v1.0"

echo "=== Creating deck via Gamma API ==="

RESPONSE=$(curl -s -X POST "$BASE/generations" \
  -H "Content-Type: application/json" \
  -H "X-API-KEY: $API_KEY" \
  -d @- <<'ENDJSON'
{
  "inputText": "# AI VENTURE BUILDER MASTERCLASS\nBuild. Scale. Support. — All With AI Agents.\nosmAgent | osmAPI | osmTalk\n\n---\n\n# The 5-Minute Venture\n[LIVE DEMO — Instructor builds a complete venture on screen in 5 minutes: brand, website, chatbot, voice agent, payment link. No slides. Pure demonstration.]\n\n---\n\n# What That Would Have Cost\n\nTHE OLD WAY vs TODAY\n\n- Time: 3-6 months → 5 minutes\n- Cost: Rs. 5-50 lakhs → Rs. 0\n- Team: 8-12 people → 1 person\n\n---\n\n# What You'll Walk Out With at 5 PM\n\n9:30 AM: An idea → 5:00 PM: A live venture taking customer calls\n\nNot a prototype. Not a pitch deck. Not a plan.\nA working business.\n\n---\n\n# Your Toolkit — 3 Platforms, 1 Stack\n\n- osmAgent — YOUR BUILDER: You tell it what to build. It builds it.\n- osmTalk — YOUR WORKFORCE: Chatbot on site. Voice on phone. Bot on WhatsApp. All 24/7.\n- osmAPI — YOUR ENGINE: 14+ AI models. INR billing. Indian-first. Low latency.\n\n---\n\n# How Today Works\n\nI DEMO (15 min) → YOU BUILD (20 min) → WE REVIEW (10 min)\n\nx 7 modules = 1 complete venture\n\n---\n\n# Let's Get You In\n\nStep 1: osmAPI.com → Sign Up → Verify email\nStep 2: app.osmtalk.com → Sign Up → Verify email\nStep 3: Open osmAgent → Start chatting\n\nStuck? Raise your hand.\n\n---\n\n# MODULE 1: FIND YOUR MILLION-DOLLAR IDEA\n10:00 - 10:45\n\n---\n\n# The 5-Point Test\n\nDoes your idea pass?\n\n1. Service delivered or orchestrated digitally\n2. Customers find you via website + chat + calls\n3. Payments collected online\n4. Support automated via AI (text + voice)\n5. Ops run on agents + minimal human oversight\n\n4 out of 5? You're building it today.\n\n---\n\n# Pick Your Arena\n\nPURELY ONLINE: AI Tutoring Academy, Fitness Coaching, Legal Consultation, Marketing Agency, Travel Concierge, Career Coaching, Bookkeeping Service, Content Agency, Translation Service, E-commerce Store, SaaS Micro-Tool\n\nONLINE + OFFLINE: Home Services Marketplace, Real Estate Brokerage, Health Clinic System, Restaurant / Cloud Kitchen, Salon / Spa Booking, Auto Repair Management, Catering & Events, Driving School, Pet Care Services, Coaching Institute, Pharmacy Delivery\n\n25+ ideas in your workbook. Or bring your own.\n\n---\n\n# What osmAgent Builds For Each Idea\n\nYOUR IDEA becomes:\n- Business description + target customer\n- 5 services with pricing\n- Revenue model\n- Competitor analysis\n- Market size estimate\n- Unique angle\n\nYou type one paragraph. It returns a business plan.\n\n---\n\n# Module 1 — Grade Your Work\n\nRate yourself 1-5:\n- Clear problem being solved\n- Defined target customer\n- Viable revenue model\n- Fully agent-creatable\n- Competitive differentiation\nTotal: /25\n\n---\n\n# MODULE 2: BUILD YOUR BRAND IN 20 MINUTES\n10:45 - 11:30\n\n---\n\n# What a Brand Agency Delivers in 3 Weeks\n\nBusiness Name, Logo (3 concepts), Color Palette, Brand Voice Guidelines, Tagline, Social Media Bios, Terms of Service, Privacy Policy\n\nTimeline: 3 weeks\nCost: Rs. 50K - 2L\n\nosmAgent delivers all of this in 10 minutes.\n\n---\n\n# Before / After\n\nBEFORE (9:30 AM): No name, no logo, no identity, no online presence, no legal docs\n\nAFTER (11:30 AM): Full brand name, logo, brand voice, tagline, ToS + Privacy Policy\n\nTotal cost of a branding agency: Rs. 50K - 2,00,000\nTotal cost today: Rs. 0\n\n---\n\n# Module 2 — Grade Your Work\n\nRate yourself 1-5:\n- Name is memorable and relevant\n- Logo is professional\n- Brand voice is consistent and distinct\n- Tagline communicates value\n- Overall brand cohesion\nTotal: /25\n\n---\n\n# BREAK — 15 MINUTES\n\nPROGRESS: Idea DONE | Brand DONE | Website _ | Chat _ | Voice _ | Growth _ | Money _\n\n2 of 7 done. Next: your home on the internet.\n\n---\n\n# MODULE 3: YOUR DIGITAL STOREFRONT\nLive in 20 minutes.\n11:45 - 12:30\n\n---\n\n# A Website That Converts\n\nWhat visitors see in the first 5 seconds decides everything.\n\n- HERO HEADLINE: One sentence. What you do. Who it's for.\n- CTA BUTTON: Book a Free Call / Get Started\n- 3 KEY BENEFITS below the fold\n- Testimonials, Services, Contact\n- Every page ends with a CTA. No dead ends.\n\n---\n\n# Module 3 — Grade Your Work\n\nRate yourself 1-5:\n- Clear value proposition above the fold\n- Professional design, matches brand\n- Services and pricing clearly presented\n- Strong CTA on every page\n- Looks great on mobile\nTotal: /25\n\n---\n\n# MODULE 4: YOUR AI RECEPTIONIST\nNever miss a customer.\n12:30 - 1:00\n\n---\n\n# It's 3:47 AM.\n\nYour website visitor: \"Do you deliver to Kondapur?\"\n\nWITHOUT osmTalk: No reply until morning. Customer gone.\n\nWITH osmTalk: \"Yes! We deliver to Kondapur. Would you like to see our meal plans?\" Customer stays. Books. Pays.\n\n---\n\n# Module 4 — Grade Your Work\n\nRate yourself 1-5:\n- Bot greets naturally\n- Answers service questions accurately\n- Handles unknown questions gracefully\n- Brand voice is consistent\nTotal: /20\n\n---\n\n# Milestone\n\nIt's 1:00 PM.\n\nYou have: A venture idea. A brand identity. A live website. An AI chatbot answering customer questions.\n\nMost funded startups don't reach this in 3 months. You did it in 3 hours.\n\n---\n\n# LUNCH — 1 HOUR\n\nScan the QR code. Visit each other's websites. Chat with the bots. Try to break them. Network. Steal ideas. That's encouraged.\n\nPROGRESS: Idea DONE | Brand DONE | Website DONE | Chat DONE | Voice _ | Growth _ | Money _\n\n4 of 7 done. The afternoon is where it gets wild.\n\n---\n\n# MODULE 5: THE VOICE OF YOUR BUSINESS\n2:00 - 2:50\n\n---\n\n# Your Phone Is About to Ring.\n\n[LIVE DEMO — Instructor dials the osmTalk voice agent on speakerphone. The AI answers a live phone call in the room.]\n\nThat agent handles 10,000 calls at once. Works 24/7. Speaks 70 languages. Never calls in sick. Now you're going to build one.\n\n---\n\n# Three Agents. One Workforce.\n\nCUSTOMER AGENT (Inbound): Answers inbound calls. Books appointments. Handles inquiries in 70+ languages.\n\nRECRUITER AGENT (Outbound): Screens job applicants. Asks 5 qualifying questions. Scores and ranks candidates.\n\nWHATSAPP AGENT (Messaging): Greets new messages. Answers FAQs. Nurtures leads with follow-ups.\n\nAll three — built in 25 minutes.\n\n---\n\n# Peer Test\n\nExchange numbers with your neighbor.\n\n1. They call YOUR voice agent.\n2. You call THEIRS.\n3. Grade each other honestly.\n\nIf your neighbor's AI sounds better than yours — ask them what they did differently.\n\n---\n\n# Module 5 — Grade Your Work\n\nRate yourself 1-5:\n- Professional greeting\n- Handles inquiries naturally\n- Captures caller info correctly\n- Multilingual readiness\n- Recruiting script is thorough\nTotal: /25\n\n---\n\n# MODULE 6: THE GROWTH ENGINE\n2:50 - 3:40\n\n---\n\n# Where Your Customers Come From\n\nFIND THEM: Social posts, WhatsApp blast, Outbound calls, Google / SEO\nENGAGE THEM: Website visit, Chatbot chat, Email sequence, WhatsApp DM\nCLOSE THEM: Free consult, Special offer, UPI payment, Testimonials\nRETAIN THEM: Support + Upsell + Referral\n\nEvery box above is powered by an AI agent. Zero of these require you to be awake.\n\n---\n\n# 30 Days of Content. Generated Now.\n\n[LIVE DEMO — Type one prompt. Watch 30 days of social media posts stream out.]\n\nA social media manager costs Rs. 30-60K/month. This took 45 seconds.\n\n---\n\n# The WhatsApp Advantage\n\nEmail open rate: 20%\nWhatsApp open rate: 98%\n\nWhere would you rather reach your customer?\n\n---\n\n# Module 6 — Grade Your Work\n\nRate yourself 1-5:\n- Content is relevant to target audience\n- WhatsApp campaign: persuasive, not pushy\n- Outbound script: natural and professional\n- Funnel has clear progression\n- Multiple lead sources identified\nTotal: /25\n\n---\n\n# BREAK — 10 MINUTES\n\nPROGRESS: Idea DONE | Brand DONE | Website DONE | Chat DONE | Voice DONE | Growth DONE | Money _\n\n6 of 7 done. Let's close the loop.\n\n---\n\n# MODULE 7: SHOW ME THE MONEY\n3:50 - 4:40\n\n---\n\n# The Full Loop\n\nCustomer finds you (social / WhatsApp / Google)\n→ Customer visits website (brand / services / pricing)\n→ Customer chats with bot (questions / pricing / CTA)\n→ Customer books / buys\n→ Customer pays via UPI (link / QR / invoice)\n→ Customer gets support (chat / voice / escalation)\n\nEvery step: automated. Every step: branded. Every step: built by you today.\n\n---\n\n# Who Handles What\n\nL1 — AI handles (80%): FAQs, tracking, scheduling, bookings\nL2 — AI + Human (15%): complaints, refunds, complex issues\nL3 — Human only (5%): legal, critical failures, VIP\n\nYour AI handles 80% of all inquiries. You step in for the 20% that matters most.\n\n---\n\n# Module 7 — Grade Your Work\n\nRate yourself 1-5:\n- Payment flow is clear and functional\n- Support bot handles post-sale queries\n- Voice support is empathetic and helpful\n- Operations docs are comprehensive\n- End-to-end experience is seamless\nTotal: /25\n\n---\n\n# The Walkthrough\n\n[LIVE — Pick 2 participants. Walk through their entire customer journey on the projector.]\n\nAsk the room: \"Would you buy from this business?\"\n\n---\n\n# Add Up Your Score\n\nModule 1 Idea /25 | Module 2 Brand /25 | Module 3 Website /25 | Module 4 Chatbot /20 | Module 5 Voice AI /25 | Module 6 Growth /25 | Module 7 Money & Ops /25\n\nTOTAL: /170\n\n145+ Launch-ready | 115-144 Almost there | 85-114 Strong foundation | Below 85 Good start\n\n---\n\n# The Cost of What You Built Today\n\nBrand identity: Rs. 50K-2L → Rs. 0\nWebsite: Rs. 50K-5L → Rs. 0\nChatbot: Rs. 20K-1L/mo → Rs. 2-5K/mo\nVoice agent: Rs. 1-3L/mo → Rs. 5-15K/mo\nLead gen: Rs. 50K-2L/mo → Rs. 5-10K/mo\nSales funnel: Rs. 30K-1L/mo → Rs. 0\nPayment system: Rs. 10-30K → Rs. 0\nSupport: Rs. 50K-2L/mo → Rs. 5-10K/mo\nRecruiting: Rs. 1-3L/mo → Rs. 5-10K/mo\n\nYEAR 1 TOTAL: Rs. 5-20 LAKHS → Rs. 20-50K/mo\nSame output. 10-40x cheaper.\n\n---\n\n# Your Next 7 Days\n\nMonday: Refine website + chatbot\nTuesday: Lock pricing + UPI payment links\nWednesday: First 5 social media posts\nThursday: WhatsApp launch campaign to 50 contacts\nFriday: Outbound lead gen voice agent — 20 calls\nSaturday: Full end-to-end test with 3 friends\nSunday: LAUNCH.\n\n---\n\n# While You Sleep Tonight\n\nYour chatbot is answering questions.\nYour voice agent is taking calls.\nYour WhatsApp bot is nurturing leads.\nYour website is converting visitors.\n\nYou are sleeping.\n\nThat's the point.\n\n---\n\n# Join the Community\n\nYour classmates are now your first support network.\nShare wins. Ask questions. Trade customers.\n\nosmAgent docs: osmAPI.com/docs\nosmTalk docs: osmtalk.com/docs\n\n---\n\n# One Last Thing.\n\nOne week ago, this venture didn't exist.\n\nToday it has a brand, a website, an AI workforce, and a growth engine.\n\nThe only question is — when are you launching?",
  "textMode": "preserve",
  "format": "presentation",
  "numCards": 48,
  "exportAs": "pdf",
  "cardOptions": {
    "dimensions": "16x9"
  },
  "textOptions": {
    "tone": "Bold, confident, CXO-level. Minimal text per slide. Show don't tell.",
    "audience": "CXOs and business leaders who are not yet AI-ready"
  },
  "imageOptions": {
    "source": "aiGenerated"
  }
}
ENDJSON
)

echo "$RESPONSE"

GEN_ID=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('generationId',''))" 2>/dev/null)

if [ -z "$GEN_ID" ]; then
  echo "ERROR: No generationId returned."
  exit 1
fi

echo ""
echo "Generation ID: $GEN_ID"
echo "Polling for completion..."

for i in $(seq 1 60); do
  sleep 5
  STATUS_RESP=$(curl -s -X GET "$BASE/generations/$GEN_ID" \
    -H "X-API-KEY: $API_KEY")

  STATUS=$(echo "$STATUS_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status','pending'))" 2>/dev/null)
  echo "  [$i] Status: $STATUS"

  if [ "$STATUS" = "completed" ]; then
    GAMMA_URL=$(echo "$STATUS_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('gammaUrl',''))" 2>/dev/null)
    EXPORT_URL=$(echo "$STATUS_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('exportUrl',''))" 2>/dev/null)

    echo ""
    echo "=== DONE ==="
    echo "Gamma URL: $GAMMA_URL"
    echo "Export URL: $EXPORT_URL"

    if [ -n "$EXPORT_URL" ]; then
      curl -sL "$EXPORT_URL" -o slides-deck-gamma.pdf
      echo "PDF saved: slides-deck-gamma.pdf ($(du -h slides-deck-gamma.pdf | cut -f1))"
    fi
    exit 0
  fi

  if [ "$STATUS" = "failed" ]; then
    echo "FAILED:"
    echo "$STATUS_RESP"
    exit 1
  fi
done

echo "Timed out after 5 minutes."
exit 1
