function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if getProperty('health') > 0.35 and not isSustainNote then
		setProperty('health', getProperty('health') - 0.01)
	end
end