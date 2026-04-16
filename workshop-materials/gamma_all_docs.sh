#!/bin/bash
# Create ALL class documents via Gamma API
# Each document is generated, polled, and downloaded as PDF

API_KEY="sk-gamma-VuUCX1TCHGRWE2c4299WjfkaFau9khMfAhnzDF7WA"
BASE="https://public-api.gamma.app/v1.0"
OUT_DIR="$(dirname "$0")/gamma-docs"
mkdir -p "$OUT_DIR"

create_and_poll() {
  local NAME="$1"
  local FILENAME="$2"
  local JSON_FILE="$3"

  echo ""
  echo "========================================="
  echo "  CREATING: $NAME"
  echo "========================================="

  RESPONSE=$(curl -s -X POST "$BASE/generations" \
    -H "Content-Type: application/json" \
    -H "X-API-KEY: $API_KEY" \
    -d @"$JSON_FILE")

  GEN_ID=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('generationId',''))" 2>/dev/null)

  if [ -z "$GEN_ID" ]; then
    echo "  ERROR: $RESPONSE"
    return 1
  fi

  echo "  Generation ID: $GEN_ID"
  WARNINGS=$(echo "$RESPONSE" | python3 -c "import sys,json; w=json.load(sys.stdin).get('warnings',''); print(w) if w else None" 2>/dev/null)
  [ -n "$WARNINGS" ] && echo "  Warnings: $WARNINGS"

  for i in $(seq 1 72); do
    sleep 5
    STATUS_RESP=$(curl -s -X GET "$BASE/generations/$GEN_ID" -H "X-API-KEY: $API_KEY")
    STATUS=$(echo "$STATUS_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status','pending'))" 2>/dev/null)

    if [ "$STATUS" = "completed" ]; then
      GAMMA_URL=$(echo "$STATUS_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('gammaUrl',''))" 2>/dev/null)
      EXPORT_URL=$(echo "$STATUS_RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('exportUrl',''))" 2>/dev/null)
      CREDITS=$(echo "$STATUS_RESP" | python3 -c "import sys,json; c=json.load(sys.stdin).get('credits',{}); print(f\"used={c.get('deducted','?')} remaining={c.get('remaining','?')}\")" 2>/dev/null)

      echo "  DONE in $((i*5))s | Credits: $CREDITS"
      echo "  View: $GAMMA_URL"

      if [ -n "$EXPORT_URL" ]; then
        curl -sL "$EXPORT_URL" -o "$OUT_DIR/$FILENAME"
        echo "  Saved: $OUT_DIR/$FILENAME ($(du -h "$OUT_DIR/$FILENAME" | cut -f1))"
      fi
      echo "$GAMMA_URL" >> "$OUT_DIR/urls.txt"
      return 0
    fi

    if [ "$STATUS" = "failed" ]; then
      echo "  FAILED: $STATUS_RESP"
      return 1
    fi

    # Progress indicator every 30s
    [ $((i % 6)) -eq 0 ] && echo "  ... still generating ($((i*5))s)"
  done

  echo "  TIMED OUT"
  return 1
}

# ──────────────────────────────────────────────────
# DOCUMENT 1: Exercise Workbook
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc1.json <<'ENDJSON'
{
  "inputText": "# AI Venture Builder Masterclass — Exercise Workbook\n\nParticipant Name: ___________________\nDate: Sunday, April 20, 2026\nInstructor: Arjun\nPlatforms: osmAgent | osmAPI | osmTalk\n\n---\n\n# Account Setup Checklist\n\nComplete before Module 1:\n- Step 1: Go to osmAPI.com > Sign Up > Enter email & password > Verify email\n- Step 2: Go to app.osmtalk.com > Sign Up > Enter email & password > Verify email\n- Step 3: Open osmAgent from the osmAPI dashboard > Confirm you see the chat interface\n\nTroubleshooting: Check spam folder if no verification email. Try incognito mode if page won't load. Raise hand if stuck.\n\n---\n\n# Module 1: Find Your Million-Dollar Idea\n\n## Your Venture Statement\nI am building _______________ for _______________ because _______________\n\n## The Agent-Creatable Test\nScore each Yes = 1, No = 0:\n1. Core service delivered digitally: ___\n2. Customer acquisition via website + chat + calls: ___\n3. Payments collected online: ___\n4. Support automated via AI: ___\n5. Ops run on agents + minimal oversight: ___\nTotal (need 4+): ___/5\n\n## Exercise: Generate Your Venture Blueprint\nOpen osmAgent. Paste this prompt (fill in your details):\n\n\"I want to start a [YOUR IDEA] business targeting [YOUR AUDIENCE] in India. Help me create: (1) A one-paragraph business description, (2) Target customer profile with demographics and pain points, (3) Top 5 services or products with suggested pricing in INR, (4) Revenue model, (5) Why this business is perfect for AI agent automation.\"\n\nThen follow up with: \"For my business: (1) Who are the top 5 competitors in India? (2) What's the estimated market size? (3) Suggest 3 unique differentiators. (4) What's the biggest risk and how do I mitigate it?\"\n\n## Self-Grade /25\n- Clear problem being solved: ___/5\n- Defined target customer: ___/5\n- Viable revenue model: ___/5\n- Fully agent-creatable: ___/5\n- Competitive differentiation: ___/5\n\n---\n\n# Module 2: Build Your Brand in 20 Minutes\n\n## Exercise: Create Your Brand Identity\n\nStep 1 — Name (use osmAgent):\n\"Generate 10 business name options for [your venture description]. Requirements: memorable, easy to pronounce, available as .com domain, appeals to [target audience].\"\nMy chosen name: _______________\n\nStep 2 — Logo:\n\"Create a professional logo for [brand name]. Business: [type]. Audience: [audience]. Style: [modern/minimal/bold/playful]. Generate 3 concepts.\"\nSelected concept: ___\n\nStep 3 — Brand Voice:\n\"Define brand voice for [brand name]. Generate: (1) Brand personality in 3 words, (2) Tone guidelines, (3) 5 sample social posts, (4) Email greeting style, (5) How we handle complaints.\"\nMy 3 personality words: _______________, _______________, _______________\n\nStep 4 — Tagline & Legal:\n\"Generate: (1) 5 tagline options, (2) 30-second elevator pitch, (3) Instagram/LinkedIn bios, (4) Terms of Service, (5) Privacy Policy.\"\nChosen tagline: _______________\n\n## Self-Grade /25\n- Memorable name: ___/5\n- Professional logo: ___/5\n- Consistent voice: ___/5\n- Clear tagline: ___/5\n- Brand cohesion: ___/5\n\n---\n\n# Module 3: Your Digital Storefront\n\n## Exercise: Build & Deploy Your Website\n\nPrompt: \"Build a professional website for [brand name]. Include: homepage with hero section and CTA, services page with [your 5 services] and pricing, about page with founder story, testimonials section, contact page with form. Use brand colors from Module 2. Make it conversion-focused.\"\n\nThen: \"Add SEO meta tags for all pages, a blog section with 3 starter posts about [industry], and Google Business Profile suggestions.\"\n\nWebsite Checklist:\n- Hero headline clear: [ ]\n- CTA above fold: [ ]\n- Services with pricing: [ ]\n- Mobile responsive: [ ]\n- Contact form works: [ ]\n\nMy live URL: _______________\nNeighbor's feedback: _______________\n\n## Self-Grade /25\n- Value proposition: ___/5\n- Design & brand match: ___/5\n- Services clear: ___/5\n- CTA placement: ___/5\n- Mobile-friendly: ___/5\n\n---\n\n# Module 4: Your AI Receptionist\n\n## Exercise: Deploy osmTalk Chatbot\n\n1. Open app.osmtalk.com > Create New Agent > Name: \"[Brand] Assistant\"\n2. Generate FAQs with osmAgent: \"Generate 15 FAQs and answers for [brand name], covering services, prices, booking, hours, location, payments, refunds, and 5 industry-specific questions.\"\n3. Add to knowledge base: FAQs + services list + pricing + business description\n4. Set greeting: \"Hi! Welcome to [Brand Name]. How can I help you today?\"\n5. Customize widget: brand colors, logo, welcome message\n6. Embed on website and test\n\nTest conversations:\n- \"What services do you offer?\" — Accurate? [ ]\n- \"How much does [service] cost?\" — Accurate? [ ]\n- \"I'd like to book\" — Works? [ ]\n- Random off-topic question — Graceful? [ ]\n\n## Self-Grade /20\n- Natural greeting: ___/5\n- Accurate answers: ___/5\n- Graceful unknowns: ___/5\n- Brand voice: ___/5\n\n---\n\n# Module 5: The Voice of Your Business\n\n## Exercise A: Customer Voice Agent (Inbound)\nIn osmTalk, create Voice Agent:\n- Name: [Brand] Customer Line\n- Voice: [select from samples]\n- Languages: English + Hindi\n- Greeting: \"Thank you for calling [Brand Name]. How can I help you today?\"\n- Configure scenarios: service inquiry, booking, pricing, complaint, directions\n- Escalation: transfer to your phone if agent can't answer\nTest: Call from your mobile phone [ ]\nInbound number: _______________\n\n## Exercise B: Recruiting Call Center (Outbound)\nCreate outbound agent:\n- Name: [Brand] HR Recruiter\n- Script questions: (1) Relevant experience? (2) Why interested? (3) Available to start when? (4) Salary expectations? (5) Questions about the role?\n- Scoring: experience 0-3, motivation 0-2, availability 0-2, salary fit 0-2, engagement 0-1\n\n## Exercise C: WhatsApp\nConnect WhatsApp > Set auto-greeting > Configure FAQ responses > Test\n\n## Peer Test\nNeighbor called my agent — feedback: _______________\n\n## Self-Grade /25\n- Professional greeting: ___/5\n- Natural inquiries: ___/5\n- Info capture: ___/5\n- Multilingual: ___/5\n- Recruiting script: ___/5\n\n---\n\n# Module 6: The Growth Engine\n\n## Exercise: Build Lead Gen & Sales\n\nStep 1 — Content Calendar:\n\"Generate a 30-day social media calendar for [brand]. Include: 15 educational, 8 promotional, 4 social proof, 3 behind-scenes posts. Format for LinkedIn + Instagram with hashtags and posting times.\"\n\nStep 2 — Email Sequence:\n\"Write 5-email welcome sequence: Email 1 (Day 0) Welcome + story, Email 2 (Day 2) Problem we solve, Email 3 (Day 5) Success story, Email 4 (Day 8) Special offer, Email 5 (Day 12) Last chance + CTA.\"\n\nStep 3 — WhatsApp Campaign:\nIn osmTalk: Create broadcast template > Launch message > Auto-reply flow > Follow-up Day 1, 3, 7\n\nStep 4 — Outbound Sales Agent:\nScript: \"Hi, I'm calling from [Brand]. We launched [service] and thought it might help. Do you have 2 minutes?\" > Qualify > Book or thank\n\nStep 5 — Map Your Funnel:\nTop (Awareness): _______________\nMiddle (Engagement): _______________\nBottom (Conversion): _______________\n\n## Self-Grade /25\n- Relevant content: ___/5\n- WhatsApp: ___/5\n- Outbound script: ___/5\n- Funnel progression: ___/5\n- Multiple lead sources: ___/5\n\n---\n\n# Module 7: Show Me the Money + Operations\n\n## Exercise: Complete the Business Loop\n\nStep 1 — Payments:\n- Generate UPI payment link for primary service\n- osmAgent: \"Create invoice template for [brand] with logo, GST, payment terms, UPI QR code.\"\n- osmAgent: \"Suggest pricing for [services] — 3 tiers: Basic, Standard (recommended), Premium.\"\n- Configure WhatsApp payment confirmation in osmTalk\n\nMy pricing: Basic Rs.___ | Standard Rs.___ | Premium Rs.___\n\nStep 2 — Support System:\nUpdate chatbot with post-sale FAQs, complaint flow, feedback collection.\nUpdate voice agent for support: \"Thank you for calling support. Let me help.\"\nEscalation matrix: L1 AI (80%) > L2 AI+Human (15%) > L3 Human (5%)\n\nStep 3 — Operations Docs:\nosmAgent: \"Generate (1) Employee onboarding guide, (2) SOPs for top 3 services, (3) Customer service scripts.\"\n\nStep 4 — End-to-End Test:\n1. Visit website: [ ] 2. Chat with bot: [ ] 3. CTA works: [ ] 4. Payment link: [ ] 5. Call voice agent: [ ] 6. WhatsApp works: [ ] 7. Professional overall: [ ]\n\nIssues to fix: _______________\n\n## Self-Grade /25\n- Payment flow: ___/5\n- Support bot: ___/5\n- Voice support: ___/5\n- Ops docs: ___/5\n- End-to-end: ___/5",
  "textMode": "preserve",
  "format": "document",
  "numCards": 20,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "noImages"}
}
ENDJSON
create_and_poll "Exercise Workbook" "01-exercise-workbook.pdf" "/tmp/gamma_doc1.json"


# ──────────────────────────────────────────────────
# DOCUMENT 2: Prompt Cheat Sheet
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc2.json <<'ENDJSON'
{
  "inputText": "# osmAgent & osmTalk — Prompt Cheat Sheet\nYour copy-paste companion for today's workshop. Every prompt you need, organized by module.\n\n---\n\n# MODULE 1 — Idea & Blueprint\n\nPrompt 1 — Venture Blueprint:\n\"I want to start a [YOUR IDEA] business targeting [YOUR AUDIENCE] in India. Help me create: (1) A one-paragraph business description, (2) Target customer profile (demographics, pain points, budget), (3) Top 5 services/products with pricing in INR, (4) Revenue model, (5) Why this is perfect for AI agent automation.\"\n\nPrompt 2 — Validation:\n\"For my [BUSINESS] business: (1) Top 5 competitors in India? (2) Estimated market size? (3) 3 unique differentiators? (4) Biggest risk and mitigation?\"\n\n---\n\n# MODULE 2 — Brand Identity\n\nPrompt 3 — Name:\n\"Generate 10 business name options for [description]. Requirements: memorable, easy to pronounce, .com domain available, appeals to [audience].\"\n\nPrompt 4 — Logo:\n\"Create a professional logo for '[NAME]'. Business: [type]. Audience: [audience]. Style: [modern/minimal/bold/playful]. Generate 3 concepts.\"\n\nPrompt 5 — Voice:\n\"Define brand voice for '[NAME]'. Generate: (1) Brand personality in 3 words, (2) Tone guidelines, (3) 5 sample social posts in our voice, (4) Email greeting style, (5) Complaint handling tone + sample.\"\n\nPrompt 6 — Tagline & Legal:\n\"Generate for '[NAME]': (1) 5 taglines (max 8 words), (2) 30-second elevator pitch, (3) Instagram/LinkedIn/Twitter bios, (4) Terms of Service for Indian business, (5) Privacy Policy.\"\n\n---\n\n# MODULE 3 — Website\n\nPrompt 7 — Full Website:\n\"Build a professional website for '[NAME]'. Include: homepage with hero section + CTA, services page with [5 services] and pricing, about page, testimonials section, contact page with form. Use brand colors [from Module 2]. Conversion-focused with clear CTAs.\"\n\nPrompt 8 — SEO & Blog:\n\"Add to my website: (1) SEO meta tags for all pages, (2) 10 target keywords, (3) Blog section with 3 starter posts about [industry], (4) Google Business Profile description.\"\n\n---\n\n# MODULE 4 — Chatbot\n\nPrompt 9 — FAQs:\n\"Generate 15 FAQs and detailed answers for '[NAME]' — covering: services, pricing, booking, hours, location, payments, refunds, delivery time, service area, rescheduling, plus 5 questions specific to [industry].\"\n\nosmTalk Setup: Create Agent > Add knowledge base (FAQs + services + pricing) > Set greeting > Customize widget colors > Embed on website.\n\n---\n\n# MODULE 5 — Voice AI\n\nosmTalk Inbound Agent: Create Voice Agent > Select voice + language > Write greeting > Configure 5 call scenarios > Set escalation rule.\n\nosmTalk Outbound Recruiter: Create Outbound Agent > Write screening script (5 questions) > Configure scoring > Enable recording.\n\nosmTalk WhatsApp: Connect WhatsApp Business > Set auto-greeting > Configure FAQ responses > Test.\n\n---\n\n# MODULE 6 — Growth\n\nPrompt 10 — Content Calendar:\n\"Generate a 30-day social media content calendar for '[NAME]'. Include: 15 educational, 8 promotional, 4 testimonial-style, 3 behind-the-scenes posts. Format for LinkedIn + Instagram with hashtags and posting times.\"\n\nPrompt 11 — Email Sequence:\n\"Write a 5-email welcome sequence: Email 1 (Day 0) Welcome + story, Email 2 (Day 2) Problem we solve, Email 3 (Day 5) Customer success, Email 4 (Day 8) Special offer, Email 5 (Day 12) Urgency + CTA. Under 200 words each, matching our brand voice.\"\n\n---\n\n# MODULE 7 — Payments & Ops\n\nPrompt 12 — Invoice:\n\"Create a professional invoice template for '[NAME]' with: logo, company details, GST, service table, payment terms, UPI QR code placeholder.\"\n\nPrompt 13 — Pricing:\n\"Suggest optimal pricing for [services] based on Indian market rates. Create 3 tiers: Basic (entry-level), Standard (recommended, best value), Premium (all-inclusive).\"\n\nPrompt 14 — Support Content:\n\"Create: (1) 10 post-purchase FAQs, (2) Complaint handling script (acknowledge > apologize > investigate > resolve > follow-up), (3) Customer feedback survey (1-5 rating + open questions).\"\n\nPrompt 15 — Operations:\n\"Generate: (1) Employee onboarding guide, (2) SOPs for top 3 services, (3) Customer service scripts for: new inquiry, lead follow-up, complaint, payment collection, referral request.\"",
  "textMode": "preserve",
  "format": "document",
  "numCards": 8,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "noImages"}
}
ENDJSON
create_and_poll "Prompt Cheat Sheet" "02-prompt-cheat-sheet.pdf" "/tmp/gamma_doc2.json"


# ──────────────────────────────────────────────────
# DOCUMENT 3: Venture Idea Gallery
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc3.json <<'ENDJSON'
{
  "inputText": "# Venture Idea Gallery — 25+ Agent-Creatable Business Ideas\n\nEvery idea below can be built, scaled, and supported entirely with AI agents using osmAgent, osmAPI, and osmTalk.\n\n---\n\n# Purely Online Ventures\n\n1. AI Tutoring Academy — Any subject, any exam. osmAgent builds course content and study materials. osmTalk handles student inquiries via chatbot, parent calls via voice, and scheduling via WhatsApp.\n\n2. Virtual Fitness & Nutrition Coaching — Personalized meal plans and workouts. osmAgent generates programs. osmTalk manages client onboarding chat, check-in calls, and WhatsApp reminders.\n\n3. Online Legal Consultation — Document templates, advice booking. osmAgent creates legal docs. osmTalk handles client intake via chatbot and appointment booking via voice.\n\n4. Digital Marketing Agency for SMBs — Campaign content, social media management, reports. osmAgent generates all content. osmTalk manages client communication and project updates.\n\n5. AI Travel Planning Concierge — Custom itineraries, booking assistance. osmAgent generates trip plans. osmTalk handles trip inquiries via chat and booking calls.\n\n6. Resume & Career Coaching — Resume writing, interview prep, career advice. osmAgent creates materials. osmTalk manages consultation booking and mock interview calls.\n\n7. Virtual Bookkeeping & Accounting — Invoice processing, GST filing, reports. osmAgent handles document generation. osmTalk manages client queries and payment reminders.\n\n8. Content & Copywriting Agency — Blog posts, social media, website copy. osmAgent generates all content. osmTalk handles client briefs and revision requests.\n\n9. Language Translation & Localization — Documents, websites, apps in 70+ languages. osmAgent translates. osmTalk handles order intake and quality check calls.\n\n10. E-commerce Niche Store — Curated products, dropshipping. osmAgent builds the store and product descriptions. osmTalk handles customer support and order tracking.\n\n11. SaaS Micro-Tool Builder — Invoice generators, proposal builders, schedulers. osmAgent builds the tool and docs. osmTalk provides user support and onboarding.\n\n12. Online Therapy & Counseling Matching — Connect patients with therapists. osmAgent creates profiles and content. osmTalk handles intake and appointment calls.\n\n13. Stock Market Research & Alerts — Research reports, trading signals. osmAgent generates analysis. osmTalk manages subscriber queries and alert calls.\n\n14. Freelancer Staffing Agency — Match freelancers to client needs. osmAgent manages profiles and matching. osmTalk handles client requirements chat and freelancer screening calls.\n\n---\n\n# Online + Offline Ventures\n\n15. Home Services Marketplace — Plumbing, electrical, cleaning on-demand. osmAgent builds listings. osmTalk handles service booking via chatbot and technician dispatch via voice calls.\n\n16. Real Estate Brokerage — Property listings, virtual tours, deal management. osmAgent creates listings. osmTalk handles property inquiry chatbot and site visit booking calls.\n\n17. Health Clinic & Diagnostic Center — Appointment system, reports, follow-ups. osmAgent builds catalog. osmTalk manages appointment booking, reminder calls, and report delivery.\n\n18. Restaurant & Cloud Kitchen — Online ordering, menu management, delivery. osmAgent creates menus. osmTalk handles order-taking chatbot, reservation calls, and feedback.\n\n19. Beauty Salon & Spa Booking — Service menu, scheduling, loyalty. osmAgent builds the platform. osmTalk manages booking chatbot, confirmation calls, and loyalty updates.\n\n20. Auto Repair Shop — Service catalog, estimate generation, scheduling. osmAgent creates pricing. osmTalk handles repair inquiry chat and pickup scheduling calls.\n\n21. Catering & Event Management — Package catalogs, custom quotes, coordination. osmAgent generates packages. osmTalk manages event inquiry chatbot and coordination calls.\n\n22. Driving School — Course catalog, scheduling, progress tracking. osmAgent builds the system. osmTalk handles enrollment chatbot, scheduling calls, and progress updates.\n\n23. Pet Care Services — Grooming, boarding, vet appointments. osmAgent creates service packages. osmTalk manages booking chatbot and appointment reminder calls.\n\n24. Coaching Institute — Course catalog, admissions, fee management. osmAgent builds content. osmTalk handles admission inquiry chatbot, parent calls, and fee reminders.\n\n25. Pharmacy & Medicine Delivery — Medicine catalog, prescription verification, delivery. osmAgent builds the catalog. osmTalk manages order chatbot and prescription verification calls.\n\n---\n\n# How to Pick Your Idea\n\nChoose based on: (1) Your domain expertise or passion, (2) A problem you've personally experienced, (3) A market you understand well, (4) Something that passes the 5-Point Agent-Creatable Test (need 4/5).\n\nRemember: You can always pivot later. Today is about learning the tools. Pick something exciting and build it.",
  "textMode": "preserve",
  "format": "document",
  "numCards": 10,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "aiGenerated"}
}
ENDJSON
create_and_poll "Venture Idea Gallery" "03-venture-idea-gallery.pdf" "/tmp/gamma_doc3.json"


# ──────────────────────────────────────────────────
# DOCUMENT 4: 7-Day Launch Plan
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc4.json <<'ENDJSON'
{
  "inputText": "# Your 7-Day Launch Plan\nFrom workshop to live business in one week.\nStick this on your desk. Check off each day.\n\n---\n\n# Monday — Polish\nRefine your website based on today's feedback. Update chatbot knowledge base with anything you missed. Fix any issues from the end-to-end test. Time needed: 2-3 hours.\n\n---\n\n# Tuesday — Price & Pay\nFinalize your 3 pricing tiers (Basic / Standard / Premium). Set up UPI payment links for each tier. Create 3 test invoices with your branded template. Send a test payment to yourself to verify the flow. Time needed: 1-2 hours.\n\n---\n\n# Wednesday — Publish\nPublish your first 5 social media posts from the 30-day content calendar. Set up your Google Business Profile (if applicable). Update your LinkedIn headline and bio with your new venture. Time needed: 1-2 hours.\n\n---\n\n# Thursday — Campaign\nSend your WhatsApp launch campaign to 50 contacts (friends, family, ex-colleagues, relevant groups). Let the AI handle every reply. Monitor conversations and refine responses. Time needed: 1 hour to send, then monitor throughout the day.\n\n---\n\n# Friday — Outreach\nActivate your outbound lead gen voice agent. Target 20 prospects (local businesses, potential clients, relevant contacts). Review call summaries and follow up with interested leads. Time needed: 1 hour setup, AI runs the calls.\n\n---\n\n# Saturday — Test\nFull end-to-end test of the customer journey. Ask 3 friends to go through the entire experience: visit website > chat with bot > call voice agent > check payment > test support. Collect their feedback and fix the gaps. Time needed: 3-4 hours.\n\n---\n\n# Sunday — LAUNCH\nWrite a LinkedIn post announcing your venture (use the template provided). Share your website URL publicly. Start accepting real customers. You are now live. Your AI workforce is running 24/7.\n\n---\n\n# Remember\nYour chatbot answers questions while you sleep. Your voice agent takes calls while you're in meetings. Your WhatsApp bot nurtures leads while you focus on strategy. You built a business with an AI workforce. Now let it work.",
  "textMode": "preserve",
  "format": "document",
  "numCards": 10,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "aiGenerated"}
}
ENDJSON
create_and_poll "7-Day Launch Plan" "04-seven-day-launch-plan.pdf" "/tmp/gamma_doc4.json"


# ──────────────────────────────────────────────────
# DOCUMENT 5: Certificate of Completion
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc5.json <<'ENDJSON'
{
  "inputText": "# Certificate of Achievement\n\n## AI Venture Builder Masterclass\n\nThis certifies that\n\n______________________________\n\nhas successfully completed the AI Venture Builder Masterclass — a full-day intensive workshop on building, scaling, and supporting AI-powered ventures using osmAgent, osmAPI, and osmTalk.\n\nDuring this workshop, the participant:\n- Identified and validated an AI-agent-creatable venture idea\n- Created a complete brand identity (name, logo, voice, tagline)\n- Built and deployed a live website\n- Configured an AI chatbot for customer engagement\n- Set up AI voice agents for inbound calls and outbound recruiting\n- Designed a complete lead generation and sales funnel\n- Established payment collection, customer support, and operations systems\n\nVenture Readiness Score: ______ / 170\n\nDate: April 20, 2026\n\nInstructor: Arjun\nAI Venture Builder Masterclass\n\nPowered by osmAgent | osmAPI | osmTalk",
  "textMode": "preserve",
  "format": "document",
  "numCards": 1,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "noImages"}
}
ENDJSON
create_and_poll "Certificate of Completion" "05-certificate.pdf" "/tmp/gamma_doc5.json"


# ──────────────────────────────────────────────────
# DOCUMENT 6: Resource & Community Guide
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc6.json <<'ENDJSON'
{
  "inputText": "# Resource & Community Guide\nEverything you need to keep building after the workshop.\n\n---\n\n# Your Platforms\n\nosmAgent (Your AI Builder): Login at osmAPI.com. This is where you create content, websites, brands, documents, and business plans. Documentation: osmAPI.com/docs.\n\nosmTalk (Your AI Workforce): Login at app.osmtalk.com. This is where you manage chatbots, voice agents, and WhatsApp automation. Documentation: osmtalk.com/docs.\n\nosmAPI (The Engine): Your AI infrastructure backbone. Routes to 14+ LLM providers with INR billing and Indian-first models. Documentation: osmAPI.com/docs.\n\n---\n\n# Community & Support\n\nWhatsApp Community Group: [QR Code placeholder] — Your classmates are your first support network. Share wins, ask questions, trade customers, and celebrate launches.\n\nInstructor Contact: Arjun — [email/phone placeholder] — For questions about the workshop, tools, or your venture strategy.\n\nosmTalk Support: support@osmtalk.com — For technical issues with chatbots, voice agents, or WhatsApp integration.\n\nosmAPI Support: support@osmapi.com — For account, billing, or platform issues.\n\n---\n\n# Recommended Next Steps (Week 2-4)\n\nWeek 2: Collect your first 5 customer testimonials. Add them to your website. Optimize your chatbot based on real conversations. Review voice agent call logs and improve scripts.\n\nWeek 3: Launch a referral program (osmTalk WhatsApp automation). Create 2 case studies from early customers. Run your second WhatsApp campaign to 200 contacts.\n\nWeek 4: Analyze your first month's data: website visits, chatbot conversations, voice calls, conversions. Hire your first human team member (screened by your AI recruiter). Set revenue targets for month 2.\n\n---\n\n# Cost Planning\n\nosmAgent: Free tier for getting started. Scale as needed.\nosmTalk: Plans from Rs. 2,000/month. Scale with call/chat volume.\nosmAPI: Pay-as-you-go with INR billing. Free tier available.\n\nTotal monthly tech cost for a new venture: Rs. 5,000 - 30,000 depending on volume. Compare to traditional costs: Rs. 2-5 lakhs/month for staff + agencies.\n\n---\n\n# Useful Prompts for After the Workshop\n\nWeekly content: \"Generate next week's social media content for [brand] based on [recent event/trend in industry].\"\n\nCustomer feedback analysis: \"Analyze these customer messages and identify: (1) Top 3 praise themes, (2) Top 3 complaint themes, (3) Suggested improvements.\"\n\nCompetitor monitoring: \"Research what [competitor name] has been doing this month. Summarize their latest offerings, pricing changes, and social media activity.\"\n\nMonthly report: \"Generate a monthly business report for [brand] covering: services delivered, revenue, customer satisfaction, and recommendations for next month.\"\n\n---\n\n# Share Your Success\n\nLinkedIn Post Template (customize and post):\n\"I just completed the AI Venture Builder Masterclass and built a live business in one day — complete with a website, AI chatbot, voice agent, and lead generation system. All powered by @osmAgent, @osmTalk, and @osmAPI.\n\n[Your venture name] is now live at [your URL].\n\nThe future of entrepreneurship isn't about headcount or funding — it's about AI agents.\n\n#AIVentureBuilder #osmAgent #osmTalk #Entrepreneurship #AIAgents\"",
  "textMode": "preserve",
  "format": "document",
  "numCards": 8,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "noImages"}
}
ENDJSON
create_and_poll "Resource & Community Guide" "06-resource-guide.pdf" "/tmp/gamma_doc6.json"


# ──────────────────────────────────────────────────
# DOCUMENT 7: Feedback Form
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc7.json <<'ENDJSON'
{
  "inputText": "# Workshop Feedback Form\nAI Venture Builder Masterclass — April 20, 2026\n\nYour honest feedback helps us make this workshop better for future participants. This takes about 3 minutes.\n\n---\n\n# Overall Experience\n\nHow would you rate today's workshop overall? (Circle one)\n1 — Poor | 2 — Below Average | 3 — Average | 4 — Good | 5 — Excellent\n\nHow likely are you to recommend this workshop to a colleague? (Circle 0-10)\n0 — Not at all likely ... 5 — Neutral ... 10 — Extremely likely\n\n---\n\n# Module Ratings\n\nRate each module from 1 (not useful) to 5 (extremely useful):\n\nModule 1 — Find Your Idea: ___/5\nModule 2 — Build Your Brand: ___/5\nModule 3 — Digital Storefront: ___/5\nModule 4 — AI Receptionist (Chatbot): ___/5\nModule 5 — Voice AI Suite: ___/5\nModule 6 — Growth Engine: ___/5\nModule 7 — Payments & Operations: ___/5\n\nWhich module was MOST valuable to you? _______________\nWhich module needs the MOST improvement? _______________\n\n---\n\n# Format & Pacing\n\nThe instruction time (demos) was: Too short / Just right / Too long\nThe exercise time (hands-on) was: Too short / Just right / Too long\nThe review time (evaluation) was: Too short / Just right / Too long\nThe overall pace was: Too slow / Just right / Too fast\n\n---\n\n# Tools & Platforms\n\nHow easy was osmAgent to use? 1 (very hard) to 5 (very easy): ___\nHow easy was osmTalk to use? 1 (very hard) to 5 (very easy): ___\nDid you face any technical issues? If yes, describe: _______________\n\n---\n\n# Your Venture\n\nDo you plan to actually launch the venture you built today? Yes / No / Maybe\nIf yes, when? This week / This month / Within 3 months / Undecided\nWhat is the #1 thing stopping you from launching? _______________\n\n---\n\n# Open Feedback\n\nWhat was the single best moment of today's workshop?\n_______________________________________________\n\nWhat is one thing you'd change about the workshop?\n_______________________________________________\n\nAny other comments, suggestions, or requests?\n_______________________________________________\n\n---\n\nThank you for your feedback! It directly shapes future workshops.\n\nName (optional): _______________\nEmail (for follow-up, optional): _______________",
  "textMode": "preserve",
  "format": "document",
  "numCards": 6,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "noImages"}
}
ENDJSON
create_and_poll "Feedback Form" "07-feedback-form.pdf" "/tmp/gamma_doc7.json"


# ──────────────────────────────────────────────────
# DOCUMENT 8: Venture Readiness Scorecard
# ──────────────────────────────────────────────────
cat > /tmp/gamma_doc8.json <<'ENDJSON'
{
  "inputText": "# Venture Readiness Scorecard\nAI Venture Builder Masterclass\n\nName: _______________  |  Venture: _______________  |  Date: April 20, 2026\n\n---\n\n# Your Scores\n\nTransfer your self-grades from each module exercise sheet.\n\nModule 1 — Venture Idea & Blueprint: ___/25\n- Clear problem being solved\n- Defined target customer\n- Viable revenue model\n- Fully agent-creatable\n- Competitive differentiation\n\nModule 2 — Brand Identity: ___/25\n- Memorable name\n- Professional logo\n- Consistent brand voice\n- Clear tagline\n- Overall brand cohesion\n\nModule 3 — Website & Digital Presence: ___/25\n- Value proposition above fold\n- Professional design\n- Services clearly presented\n- Strong CTA placement\n- Mobile responsive\n\nModule 4 — AI Chatbot: ___/20\n- Natural greeting\n- Accurate service answers\n- Graceful unknown handling\n- Brand voice consistency\n\nModule 5 — Voice AI Suite: ___/25\n- Professional greeting\n- Handles inquiries naturally\n- Captures info correctly\n- Multilingual readiness\n- Recruiting script thorough\n\nModule 6 — Growth Engine: ___/25\n- Relevant content\n- WhatsApp: persuasive not pushy\n- Outbound: natural script\n- Clear funnel progression\n- Multiple lead sources\n\nModule 7 — Revenue & Operations: ___/25\n- Payment flow functional\n- Support bot handles post-sale\n- Voice support empathetic\n- Ops docs comprehensive\n- End-to-end seamless\n\n---\n\n# TOTAL SCORE: _____ / 170\n\n145+ points — LAUNCH-READY: You could start selling tomorrow. Your venture has all the pieces in place. Focus: get your first 5 customers this week.\n\n115–144 points — ALMOST THERE: 2-3 hours of refinement and you're live. Revisit modules that scored below 15. Focus: polish your weakest areas tonight.\n\n85–114 points — STRONG FOUNDATION: You have the structure. Spend this week rebuilding modules that scored below 12. Focus: one module per evening.\n\nBelow 85 — GOOD START: Don't worry. You have all the tools and all the prompts. Revisit the exercise sheets, redo the weak modules, and ask for help in the community WhatsApp group.\n\n---\n\n# What You Built Today\n\nCheck everything you completed:\n- [ ] Validated venture idea with business blueprint\n- [ ] Complete brand (name, logo, voice, tagline, legal docs)\n- [ ] Live website with SEO and blog content\n- [ ] AI chatbot handling customer inquiries 24/7\n- [ ] Voice AI agent answering phone calls\n- [ ] Recruiting call center screening candidates\n- [ ] WhatsApp business automation\n- [ ] 30-day social media content calendar\n- [ ] 5-email marketing welcome sequence\n- [ ] WhatsApp campaign with follow-up sequences\n- [ ] Outbound sales call agent\n- [ ] UPI payment collection with branded invoicing\n- [ ] Customer support system (chat + voice + escalation)\n- [ ] Operations documents (SOPs, onboarding, scripts)\n\n---\n\n# Cost Reality Check\n\nWhat you built traditionally costs Rs. 5-20 lakhs in year one.\nYour AI agent cost: Rs. 20,000-50,000 per month.\nThat's a 10-40x cost advantage.\nSame output. Fraction of the cost. No headcount.",
  "textMode": "preserve",
  "format": "document",
  "numCards": 6,
  "exportAs": "pdf",
  "cardOptions": {"dimensions": "a4"},
  "imageOptions": {"source": "noImages"}
}
ENDJSON
create_and_poll "Venture Readiness Scorecard" "08-venture-readiness-scorecard.pdf" "/tmp/gamma_doc8.json"


# ──────────────────────────────────────────────────
# SUMMARY
# ──────────────────────────────────────────────────
echo ""
echo "========================================="
echo "  ALL DOCUMENTS COMPLETE"
echo "========================================="
echo ""
echo "Files in $OUT_DIR:"
ls -lh "$OUT_DIR"/*.pdf 2>/dev/null
echo ""
echo "Gamma URLs:"
cat "$OUT_DIR/urls.txt" 2>/dev/null
